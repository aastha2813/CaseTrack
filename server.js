const express = require('express');
const cors = require('cors');
const path = require('path');
const db = require('./db');

const app = express();
const PORT = process.env.PORT || 3000;

app.use(cors());
app.use(express.json());
app.use(express.static(path.join(__dirname, 'public')));

// PostgreSQL normalizes all unquoted column names to lowercase.
// Since the frontend React application expects specific PascalCase / camelCase keys
// (e.g. Case_Id, Start_Date, Crime_Type, etc.), this casing map dynamically normalizes 
// the property names returned in row objects.
const casingMap = {
  case_id: 'Case_Id',
  title: 'Title',
  description: 'Description',
  start_date: 'Start_Date',
  status: 'Status',
  crime_type: 'Crime_Type',
  
  scene_id: 'Scene_id',
  date_reported: 'Date_Reported',
  city: 'City',
  address: 'Address',
  
  officer_id: 'Officer_Id',
  name: 'Name',
  officer_rank: 'Officer_Rank',
  department: 'Department',
  role_in_case: 'Role_In_Case',
  
  suspect_id: 'Suspect_Id',
  dob: 'DOB',
  gender: 'Gender',
  criminal_history: 'Criminal_History',
  suspicion_level: 'Suspicion_Level',
  
  clue_id: 'Clue_Id',
  discovered_date: 'Discovered_Date',
  location: 'Location',
  
  evidence_id: 'Evidence_Id',
  type: 'Type',
  storage_location: 'Storage_Location',
  
  verdict_id: 'Verdict_Id',
  decision: 'Decision',
  date: 'Date',
  remarks: 'Remarks',
  
  advocate_id: 'Advocate_Id',
  advocate_name: 'Advocate_Name',
  role: 'Role',
  experience_years: 'Experience_Years',
  
  judge_id: 'Judge_Id',
  judge_name: 'Judge_Name',
  court_name: 'Court_Name',

  user_id: 'User_Id',
  full_name: 'Full_Name',
  username: 'Username',
  email: 'Email',
  phone: 'Phone'
};

function normalizeRow(row) {
  if (!row) return null;
  const normalized = {};
  for (const key of Object.keys(row)) {
    const mappedKey = casingMap[key.toLowerCase()] || key;
    normalized[mappedKey] = row[key];
  }
  return normalized;
}

function normalizeRows(rows) {
  if (!rows) return [];
  return rows.map(normalizeRow);
}

function formatDate(dateObj) {
  if (!dateObj) return '';
  if (typeof dateObj === 'string') {
    if (dateObj.includes('T')) {
      dateObj = new Date(dateObj);
    } else {
      return dateObj;
    }
  }
  if (!(dateObj instanceof Date) || isNaN(dateObj.getTime())) return '';
  const d = String(dateObj.getDate()).padStart(2, '0');
  const m = String(dateObj.getMonth() + 1).padStart(2, '0');
  const y = dateObj.getFullYear();
  return `${d}-${m}-${y}`;
}

// ─── Authentication API Endpoints ───

app.post('/api/login', async (req, res) => {
  try {
    const { username, password, role } = req.body;
    if (!username || !password || !role) {
      return res.status(400).json({ error: 'Username, password, and role are required.' });
    }

    const queryText = `
      SELECT user_id, full_name, username, email, phone, role
      FROM users
      WHERE username = $1
      AND password = $2
      AND role = $3;
    `;
    const result = await db.query(queryText, [username, password, role]);

    if (result.rows.length === 0) {
      return res.status(401).json({ error: 'Invalid username or password.' });
    }

    const user = normalizeRow(result.rows[0]);
    res.json({
      user_id: user.User_Id || user.user_id,
      full_name: user.Full_Name || user.full_name,
      username: user.Username || user.username,
      role: user.Role || user.role
    });
  } catch (err) {
    console.error('Error logging in:', err.message);
    res.status(500).json({ error: 'Server error' });
  }
});

app.post('/api/signup', async (req, res) => {
  try {
    const { full_name, username, email, phone, password, confirmPassword } = req.body;
    if (!full_name || !username || !email || !phone || !password || !confirmPassword) {
      return res.status(400).json({ error: 'All fields are required.' });
    }

    if (password !== confirmPassword) {
      return res.status(400).json({ error: 'Password and Confirm Password do not match.' });
    }

    // Check if username already exists in existing users table
    const userCheck = await db.query('SELECT user_id FROM users WHERE username = $1', [username]);
    if (userCheck.rows.length > 0) {
      return res.status(400).json({ error: 'Username already exists.' });
    }

    // Check if email already exists in existing users table
    const emailCheck = await db.query('SELECT user_id FROM users WHERE email = $1', [email]);
    if (emailCheck.rows.length > 0) {
      return res.status(400).json({ error: 'Email already exists.' });
    }

    // Generate automatic UXXX format user_id on backend
    const idResult = await db.query("SELECT user_id FROM users WHERE user_id LIKE 'U%'");
    const lastNum = idResult.rows.reduce((max, u) => {
      const uId = u.user_id || '';
      const num = parseInt(uId.replace('U', ''), 10);
      return isNaN(num) ? max : Math.max(max, num);
    }, 0);
    const newId = 'U' + String(lastNum + 1).padStart(3, '0');

    // Insert directly into EXISTING users table
    await db.query(`
      INSERT INTO users (user_id, full_name, username, email, phone, password, role)
      VALUES ($1, $2, $3, $4, $5, $6, 'user')
    `, [newId, full_name, username, email, phone, password]);

    res.status(201).json({ message: 'Account created successfully. Please login.' });
  } catch (err) {
    console.error('Error signing up:', err.message);
    res.status(500).json({ error: 'Failed to sign up.' });
  }
});

// ─── Case File API Endpoints ───

app.get('/api/cases', async (req, res) => {
  const userId = req.headers['x-user-id'];
  const userRole = req.headers['x-user-role'];

  try {
    let result;
    if (userRole === 'admin') {
      // Admin sees ALL cases
      result = await db.query('SELECT * FROM CaseFile ORDER BY Start_Date DESC');
    } else if (userId) {
      // Normal user sees ONLY cases associated with their user_id in user_case
      result = await db.query(`
        SELECT c.*
        FROM CaseFile c
        JOIN user_case uc ON c.case_id = uc.case_id
        WHERE uc.user_id = $1
        ORDER BY c.start_date DESC
      `, [userId]);
    } else {
      return res.status(401).json({ error: 'Unauthorized' });
    }

    const cases = normalizeRows(result.rows).map(c => ({
      ...c,
      Start_Date: formatDate(c.Start_Date)
    }));
    res.json(cases);
  } catch (err) {
    console.error('Error fetching cases:', err.message);
    res.status(500).json({ error: 'Failed to load cases' });
  }
});

app.get('/api/cases/:id', async (req, res) => {
  try {
    const result = await db.query('SELECT * FROM CaseFile WHERE Case_Id = $1', [req.params.id.toUpperCase()]);
    if (result.rows.length === 0) return res.status(404).json({ error: 'Case not found' });
    const found = normalizeRow(result.rows[0]);
    found.Start_Date = formatDate(found.Start_Date);
    res.json(found);
  } catch (err) {
    console.error('Error fetching case:', err.message);
    res.status(500).json({ error: 'Server error' });
  }
});

app.get('/api/cases/:id/details', async (req, res) => {
  const id = req.params.id.toUpperCase();
  try {
    const [
      caseRes, sceneRes, officersRes, suspectRes, 
      evidenceRes, clueRes, verdictRes, advocateRes, judgeRes
    ] = await Promise.all([
      db.query('SELECT * FROM CaseFile WHERE Case_Id = $1', [id]),
      db.query('SELECT * FROM CrimeScene WHERE Case_Id = $1', [id]),
      db.query(`
        SELECT o.*, co.Role_In_Case 
        FROM Officer o 
        JOIN CaseOfficer co ON o.Officer_Id = co.Officer_Id 
        WHERE co.Case_Id = $1
      `, [id]),
      db.query('SELECT * FROM CaseSuspect WHERE Case_Id = $1', [id]),
      db.query('SELECT * FROM Evidence WHERE Case_Id = $1', [id]),
      db.query('SELECT * FROM Clue WHERE Case_Id = $1', [id]),
      db.query('SELECT * FROM Verdict WHERE Case_Id = $1', [id]),
      db.query('SELECT * FROM CaseAdvocate WHERE Case_Id = $1', [id]),
      db.query('SELECT * FROM CaseJudge WHERE Case_Id = $1', [id])
    ]);

    if (caseRes.rows.length === 0) return res.status(404).json({ error: 'Case not found' });

    const caseData = normalizeRow(caseRes.rows[0]);
    caseData.Start_Date = formatDate(caseData.Start_Date);

    const crimeScene = normalizeRow(sceneRes.rows[0]) || null;
    if (crimeScene) crimeScene.Date_Reported = formatDate(crimeScene.Date_Reported);

    const officers = normalizeRows(officersRes.rows);
    const suspects = normalizeRows(suspectRes.rows);
    suspects.forEach(r => r.DOB = formatDate(r.DOB));

    const evidence = normalizeRows(evidenceRes.rows);
    const clues = normalizeRows(clueRes.rows);
    clues.forEach(r => r.Discovered_Date = formatDate(r.Discovered_Date));

    const verdict = normalizeRow(verdictRes.rows[0]) || null;
    if (verdict) verdict.Date = formatDate(verdict.Date);

    const advocates = normalizeRows(advocateRes.rows);
    const judge = normalizeRow(judgeRes.rows[0]) || null;

    res.json({
      case: caseData,
      crimeScene,
      officers,
      suspects,
      evidence,
      clues,
      verdict,
      advocates,
      judge
    });
  } catch (err) {
    console.error('Error fetching case details:', err.message);
    res.status(500).json({ error: 'Server error' });
  }
});

app.get('/api/dashboard', async (req, res) => {
  const userId = req.headers['x-user-id'];
  const userRole = req.headers['x-user-role'];

  try {
    let result;
    if (userRole === 'admin') {
      result = await db.query('SELECT Status, Crime_Type FROM CaseFile');
    } else if (userId) {
      result = await db.query(`
        SELECT c.status, c.crime_type
        FROM CaseFile c
        JOIN user_case uc ON c.case_id = uc.case_id
        WHERE uc.user_id = $1
      `, [userId]);
    } else {
      return res.status(401).json({ error: 'Unauthorized' });
    }

    const cases = normalizeRows(result.rows);
    
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
    console.error('Error fetching dashboard stats:', err.message);
    res.status(500).json({ error: 'Failed to load dashboard data' });
  }
});

app.post('/api/cases', async (req, res) => {
  const userId = req.headers['x-user-id'];

  try {
    const { Title, Description, Start_Date, Status, Crime_Type } = req.body;
    if (!Title || !Description || !Start_Date || !Status || !Crime_Type) {
      return res.status(400).json({ error: 'All fields are required' });
    }

    const [d, m, y] = Start_Date.split('-');
    const sqlDate = `${y}-${m}-${d}`;

    // Execute in a single PostgreSQL transaction
    const client = await db.pool.connect();
    try {
      await client.query('BEGIN');

      const idResult = await client.query('SELECT case_id FROM casefile');
      const lastNum = idResult.rows.reduce((max, c) => {
        const cId = c.case_id || '';
        const num = parseInt(cId.replace('C', ''), 10);
        return isNaN(num) ? max : Math.max(max, num);
      }, 0);
      const newId = 'C' + String(lastNum + 1).padStart(3, '0');

      // 1. Insert into EXISTING casefile table
      await client.query(`
        INSERT INTO casefile (case_id, title, description, start_date, status, crime_type)
        VALUES ($1, $2, $3, $4, $5, $6)
      `, [newId, Title, Description, sqlDate, Status, Crime_Type]);

      // 2. If registered by a normal user (not admin), insert connection into EXISTING user_case table
      if (userId && userId.startsWith('U')) {
        await client.query(`
          INSERT INTO user_case (user_id, case_id)
          VALUES ($1, $2)
        `, [userId, newId]);
      }

      await client.query('COMMIT');

      const newCase = { Case_Id: newId, Title, Description, Start_Date, Status, Crime_Type };
      res.status(201).json({ message: 'Case added successfully', case: newCase });
    } catch (txErr) {
      await client.query('ROLLBACK');
      throw txErr;
    } finally {
      client.release();
    }
  } catch (err) {
    console.error('Error adding case:', err.message);
    res.status(500).json({ error: 'Failed to add case' });
  }
});

app.patch('/api/cases/:id/status', async (req, res) => {
  try {
    const id = req.params.id.toUpperCase();
    const { status } = req.body;
    if (!status) return res.status(400).json({ error: 'status is required' });

    const result = await db.query('UPDATE CaseFile SET Status = $1 WHERE Case_Id = $2', [status, id]);
    
    if (result.rowCount === 0) return res.status(404).json({ error: 'Case not found' });
    res.json({ message: 'Status updated' });
  } catch (err) {
    console.error('Error updating case status:', err.message);
    res.status(500).json({ error: 'Failed to update status' });
  }
});

app.post('/api/cases/:id/suspect', async (req, res) => {
  try {
    const id = req.params.id.toUpperCase();
    const { Name, DOB, Gender, Criminal_History, Suspicion_Level, Role_In_Case } = req.body;

    const [d, m, y] = DOB.split('-');
    const sqlDate = `${y}-${m}-${d}`;

    const idResult = await db.query('SELECT Suspect_Id FROM CaseSuspect');
    const lastNum = idResult.rows.reduce((max, s) => {
      const normalized = normalizeRow(s);
      const num = parseInt(normalized.Suspect_Id.replace('SUS', ''), 10);
      return isNaN(num) ? max : Math.max(max, num);
    }, 0);
    const newId = 'SUS' + String(lastNum + 1).padStart(3, '0');

    await db.query(`
      INSERT INTO CaseSuspect (Suspect_Id, Case_Id, Name, DOB, Gender, Criminal_History, Suspicion_Level, Role_In_Case)
      VALUES ($1, $2, $3, $4, $5, $6, $7, $8)
    `, [newId, id, Name, sqlDate, Gender, Criminal_History, Suspicion_Level, Role_In_Case]);

    res.status(201).json({ message: 'Suspect added' });
  } catch (err) {
    console.error('Error adding suspect:', err.message);
    res.status(500).json({ error: 'Failed to add suspect' });
  }
});

app.post('/api/cases/:id/evidence', async (req, res) => {
  try {
    const id = req.params.id.toUpperCase();
    const { Type, Description, Storage_Location } = req.body;

    const idResult = await db.query('SELECT Evidence_Id FROM Evidence');
    const lastNum = idResult.rows.reduce((max, e) => {
      const normalized = normalizeRow(e);
      const num = parseInt(normalized.Evidence_Id.replace('E', ''), 10);
      return isNaN(num) ? max : Math.max(max, num);
    }, 0);
    const newId = 'E' + String(lastNum + 1).padStart(3, '0');

    await db.query(`
      INSERT INTO Evidence (Evidence_Id, Case_Id, Type, Description, Storage_Location)
      VALUES ($1, $2, $3, $4, $5)
    `, [newId, id, Type, Description, Storage_Location]);

    res.status(201).json({ message: 'Evidence added' });
  } catch (err) {
    console.error('Error adding evidence:', err.message);
    res.status(500).json({ error: 'Failed to add evidence' });
  }
});

app.post('/api/cases/:id/judge', async (req, res) => {
  try {
    const id = req.params.id.toUpperCase();
    const { Judge_Name, Court_Name } = req.body;

    const idResult = await db.query('SELECT Judge_Id FROM CaseJudge');
    const lastNum = idResult.rows.reduce((max, j) => {
      const normalized = normalizeRow(j);
      const num = parseInt(normalized.Judge_Id.replace('J', ''), 10);
      return isNaN(num) ? max : Math.max(max, num);
    }, 0);
    const newJudgeId = 'J' + String(lastNum + 1).padStart(3, '0');

    await db.query('DELETE FROM CaseJudge WHERE Case_Id = $1', [id]);

    await db.query(`
      INSERT INTO CaseJudge (Judge_Id, Case_Id, Judge_Name, Court_Name)
      VALUES ($1, $2, $3, $4)
    `, [newJudgeId, id, Judge_Name, Court_Name]);

    res.status(201).json({ message: 'Judge assigned' });
  } catch (err) {
    console.error('Error assigning judge:', err.message);
    res.status(500).json({ error: 'Failed to assign judge' });
  }
});

app.post('/api/cases/:id/advocate', async (req, res) => {
  try {
    const id = req.params.id.toUpperCase();
    const { Advocate_Name, Role, Experience_Years } = req.body;

    const idResult = await db.query('SELECT Advocate_Id FROM CaseAdvocate');
    const lastNum = idResult.rows.reduce((max, a) => {
      const normalized = normalizeRow(a);
      const num = parseInt(normalized.Advocate_Id.replace('A', ''), 10);
      return isNaN(num) ? max : Math.max(max, num);
    }, 0);
    const newId = 'A' + String(lastNum + 1).padStart(3, '0');

    await db.query(`
      INSERT INTO CaseAdvocate (Advocate_Id, Case_Id, Advocate_Name, Role, Experience_Years)
      VALUES ($1, $2, $3, $4, $5)
    `, [newId, id, Advocate_Name, Role, parseInt(Experience_Years, 10)]);

    res.status(201).json({ message: 'Advocate assigned' });
  } catch (err) {
    console.error('Error assigning advocate:', err.message);
    res.status(500).json({ error: 'Failed to assign advocate' });
  }
});

app.get('/api/officers', async (req, res) => {
  try {
    const result = await db.query('SELECT * FROM Officer');
    res.json(normalizeRows(result.rows));
  } catch (err) {
    console.error('Error fetching officers:', err.message);
    res.status(500).json({ error: 'Failed to load officers' });
  }
});

app.get('/{*any}', (req, res) => {
  res.sendFile(path.join(__dirname, 'public', 'index.html'));
});

app.listen(PORT, () => {
  console.log(`\nCaseTrack Server running at http://localhost:${PORT}\n`);
});
