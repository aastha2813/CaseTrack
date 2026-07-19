const express = require('express');
const cors = require('cors');
const path = require('path');
const sql = require('mssql/msnodesqlv8');

const app = express();
const PORT = 3000;

app.use(cors());
app.use(express.json());
app.use(express.static(path.join(__dirname, 'public')));

const dbConfig = {
    server: 'localhost\\SQLEXPRESS',
    database: 'CaseTrack',
    driver: 'ODBC Driver 17 for SQL Server',
    options: {
        trustedConnection: true,
        encrypt: false
    }
};

let pool;
async function connectDB() {
  try {
    pool = await sql.connect(dbConfig);
    console.log('✅ Connected to MS SQL Server (CaseTrack database)');
  } catch (err) {
    console.error('❌ Database Connection Failed! Are you sure SQL Server is running?', err.message);
  }
}
connectDB();

function formatDate(dateObj) {
  if (!dateObj) return '';
  const d = String(dateObj.getDate()).padStart(2, '0');
  const m = String(dateObj.getMonth() + 1).padStart(2, '0');
  const y = dateObj.getFullYear();
  return `${d}-${m}-${y}`;
}


app.get('/api/cases', async (req, res) => {
  try {
    const result = await pool.request().query('SELECT * FROM CaseFile ORDER BY Start_Date DESC');
    const cases = result.recordset.map(c => ({
      ...c,
      Start_Date: formatDate(c.Start_Date)
    }));
    res.json(cases);
  } catch (err) {
    console.error(err);
    res.status(500).json({ error: 'Failed to load cases' });
  }
});

app.get('/api/cases/:id', async (req, res) => {
  try {
    const result = await pool.request()
      .input('id', sql.VarChar, req.params.id.toUpperCase())
      .query('SELECT * FROM CaseFile WHERE Case_Id = @id');
    
    if (result.recordset.length === 0) return res.status(404).json({ error: 'Case not found' });
    const found = result.recordset[0];
    found.Start_Date = formatDate(found.Start_Date);
    res.json(found);
  } catch (err) {
    console.error(err);
    res.status(500).json({ error: 'Server error' });
  }
});

app.get('/api/cases/:id/details', async (req, res) => {
  const id = req.params.id.toUpperCase();
  try {
    const request = () => pool.request().input('id', sql.VarChar, id);

    const [
      caseRes, sceneRes, officersRes, suspectRes, 
      evidenceRes, clueRes, verdictRes, advocateRes, judgeRes
    ] = await Promise.all([
      request().query('SELECT * FROM CaseFile WHERE Case_Id = @id'),
      request().query('SELECT * FROM CrimeScene WHERE Case_Id = @id'),
      request().query(`
        SELECT o.*, co.Role_In_Case 
        FROM Officer o 
        JOIN CaseOfficer co ON o.Officer_Id = co.Officer_Id 
        WHERE co.Case_Id = @id
      `),
      request().query('SELECT * FROM CaseSuspect WHERE Case_Id = @id'),
      request().query('SELECT * FROM Evidence WHERE Case_Id = @id'),
      request().query('SELECT * FROM Clue WHERE Case_Id = @id'),
      request().query('SELECT * FROM Verdict WHERE Case_Id = @id'),
      request().query('SELECT * FROM CaseAdvocate WHERE Case_Id = @id'),
      request().query('SELECT * FROM CaseJudge WHERE Case_Id = @id')
    ]);

    if (caseRes.recordset.length === 0) return res.status(404).json({ error: 'Case not found' });

    const caseData = caseRes.recordset[0];
    caseData.Start_Date = formatDate(caseData.Start_Date);

    // Format dates in child records
    sceneRes.recordset.forEach(r => r.Date_Reported = formatDate(r.Date_Reported));
    suspectRes.recordset.forEach(r => r.DOB = formatDate(r.DOB));
    clueRes.recordset.forEach(r => r.Discovered_Date = formatDate(r.Discovered_Date));
    verdictRes.recordset.forEach(r => r.Date = formatDate(r.Date));

    res.json({
      case: caseData,
      crimeScene: sceneRes.recordset[0] || null,
      officers: officersRes.recordset,
      suspects: suspectRes.recordset,
      evidence: evidenceRes.recordset,
      clues: clueRes.recordset,
      verdict: verdictRes.recordset[0] || null,
      advocates: advocateRes.recordset,
      judge: judgeRes.recordset[0] || null
    });
  } catch (err) {
    console.error(err);
    res.status(500).json({ error: 'Server error' });
  }
});

app.get('/api/dashboard', async (req, res) => {
  try {
    const result = await pool.request().query('SELECT Status, Crime_Type FROM CaseFile');
    const cases = result.recordset;
    
    const total = cases.length;
    const open = cases.filter(c => c.Status === 'Open').length;
    const closed = cases.filter(c => c.Status === 'Closed').length;
    const underInvestigation = cases.filter(c => c.Status === 'Under Investigation').length;

    const crimeTypeCounts = {};
    cases.forEach(c => {
      crimeTypeCounts[c.Crime_Type] = (crimeTypeCounts[c.Crime_Type] || 0) + 1;
    });

    res.json({ total, open, closed, underInvestigation, crimeTypeCounts });
  } catch (err) {
    console.error(err);
    res.status(500).json({ error: 'Failed to load dashboard data' });
  }
});

app.post('/api/cases', async (req, res) => {
  try {
    const { Title, Description, Start_Date, Status, Crime_Type } = req.body;
    if (!Title || !Description || !Start_Date || !Status || !Crime_Type) {
      return res.status(400).json({ error: 'All fields are required' });
    }

  
    const [d, m, y] = Start_Date.split('-');
    const sqlDate = `${y}-${m}-${d}`;

    const idResult = await pool.request().query("SELECT Case_Id FROM CaseFile");
    const lastNum = idResult.recordset.reduce((max, c) => {
      const num = parseInt(c.Case_Id.replace('C', ''), 10);
      return isNaN(num) ? max : Math.max(max, num);
    }, 0);
    const newId = 'C' + String(lastNum + 1).padStart(3, '0');

    await pool.request()
      .input('id', sql.VarChar, newId)
      .input('title', sql.VarChar, Title)
      .input('desc', sql.VarChar, Description)
      .input('date', sql.Date, sqlDate)
      .input('status', sql.VarChar, Status)
      .input('type', sql.VarChar, Crime_Type)
      .query(`
        INSERT INTO CaseFile (Case_Id, Title, Description, Start_Date, Status, Crime_Type)
        VALUES (@id, @title, @desc, @date, @status, @type)
      `);

    const newCase = { Case_Id: newId, Title, Description, Start_Date, Status, Crime_Type };
    res.status(201).json({ message: 'Case added successfully', case: newCase });
  } catch (err) {
    console.error(err);
    res.status(500).json({ error: 'Failed to add case' });
  }
});

app.patch('/api/cases/:id/status', async (req, res) => {
  try {
    const id = req.params.id.toUpperCase();
    const { status } = req.body;
    if (!status) return res.status(400).json({ error: 'status is required' });

    const result = await pool.request()
      .input('id', sql.VarChar, id)
      .input('status', sql.VarChar, status)
      .query('UPDATE CaseFile SET Status = @status WHERE Case_Id = @id');
    
    if (result.rowsAffected[0] === 0) return res.status(404).json({ error: 'Case not found' });
    res.json({ message: 'Status updated' });
  } catch (err) {
    console.error(err);
    res.status(500).json({ error: 'Failed to update status' });
  }
});

app.post('/api/cases/:id/suspect', async (req, res) => {
  try {
    const id = req.params.id.toUpperCase();
    const { Name, DOB, Gender, Criminal_History, Suspicion_Level, Role_In_Case } = req.body;

    const [d, m, y] = DOB.split('-');
    const sqlDate = `${y}-${m}-${d}`;

    const idResult = await pool.request().query("SELECT Suspect_Id FROM CaseSuspect");
    const lastNum = idResult.recordset.reduce((max, s) => {
      const num = parseInt(s.Suspect_Id.replace('SUS', ''), 10);
      return isNaN(num) ? max : Math.max(max, num);
    }, 0);
    const newId = 'SUS' + String(lastNum + 1).padStart(3, '0');

    await pool.request()
      .input('susId', sql.VarChar, newId)
      .input('caseId', sql.VarChar, id)
      .input('name', sql.VarChar, Name)
      .input('dob', sql.Date, sqlDate)
      .input('gender', sql.VarChar, Gender)
      .input('history', sql.VarChar, Criminal_History)
      .input('level', sql.VarChar, Suspicion_Level)
      .input('role', sql.VarChar, Role_In_Case)
      .query(`
        INSERT INTO CaseSuspect (Suspect_Id, Case_Id, Name, DOB, Gender, Criminal_History, Suspicion_Level, Role_In_Case)
        VALUES (@susId, @caseId, @name, @dob, @gender, @history, @level, @role)
      `);

    res.status(201).json({ message: 'Suspect added' });
  } catch (err) {
    console.error(err);
    res.status(500).json({ error: 'Failed to add suspect' });
  }
});

app.post('/api/cases/:id/evidence', async (req, res) => {
  try {
    const id = req.params.id.toUpperCase();
    const { Type, Description, Storage_Location } = req.body;

    const idResult = await pool.request().query("SELECT Evidence_Id FROM Evidence");
    const lastNum = idResult.recordset.reduce((max, e) => {
      const num = parseInt(e.Evidence_Id.replace('E', ''), 10);
      return isNaN(num) ? max : Math.max(max, num);
    }, 0);
    const newId = 'E' + String(lastNum + 1).padStart(3, '0');

    await pool.request()
      .input('evId', sql.VarChar, newId)
      .input('caseId', sql.VarChar, id)
      .input('type', sql.VarChar, Type)
      .input('desc', sql.VarChar, Description)
      .input('storage', sql.VarChar, Storage_Location)
      .query(`
        INSERT INTO Evidence (Evidence_Id, Case_Id, Type, Description, Storage_Location)
        VALUES (@evId, @caseId, @type, @desc, @storage)
      `);

    res.status(201).json({ message: 'Evidence added' });
  } catch (err) {
    console.error(err);
    res.status(500).json({ error: 'Failed to add evidence' });
  }
});

app.post('/api/cases/:id/judge', async (req, res) => {
  try {
    const id = req.params.id.toUpperCase();
    const { Judge_Name, Court_Name } = req.body;

    await pool.request()
      .input('caseId', sql.VarChar, id)
      .query('DELETE FROM CaseJudge WHERE Case_Id = @caseId');

    await pool.request()
      .input('caseId', sql.VarChar, id)
      .input('jName', sql.VarChar, Judge_Name)
      .input('court', sql.VarChar, Court_Name)
      .query(`
        INSERT INTO CaseJudge (Case_Id, Judge_Name, Court_Name)
        VALUES (@caseId, @jName, @court)
      `);

    res.status(201).json({ message: 'Judge assigned' });
  } catch (err) {
    console.error(err);
    res.status(500).json({ error: 'Failed to assign judge' });
  }
});

app.post('/api/cases/:id/advocate', async (req, res) => {
  try {
    const id = req.params.id.toUpperCase();
    const { Advocate_Name, Role, Experience_Years } = req.body;

    await pool.request()
      .input('caseId', sql.VarChar, id)
      .input('name', sql.VarChar, Advocate_Name)
      .input('role', sql.VarChar, Role)
      .input('exp', sql.Int, parseInt(Experience_Years, 10))
      .query(`
        INSERT INTO CaseAdvocate (Case_Id, Advocate_Name, Role, Experience_Years)
        VALUES (@caseId, @name, @role, @exp)
      `);

    res.status(201).json({ message: 'Advocate assigned' });
  } catch (err) {
    console.error(err);
    res.status(500).json({ error: 'Failed to assign advocate' });
  }
});

app.get('/api/officers', async (req, res) => {
  try {
    const result = await pool.request().query('SELECT * FROM Officer');
    res.json(result.recordset);
  } catch (err) {
    console.error(err);
    res.status(500).json({ error: 'Failed to load officers' });
  }
});

app.get('/{*any}', (req, res) => {
  res.sendFile(path.join(__dirname, 'public', 'index.html'));
});

app.listen(PORT, () => {
  console.log(`\nCaseTrack Server running at http://localhost:${PORT}\n`);
});
