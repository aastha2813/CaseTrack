const sql = require('mssql/msnodesqlv8');

const configs = [
  {
    server: 'localhost\\SQLEXPRESS',
    database: 'CaseTrack',
    driver: 'msnodesqlv8',
    options: { trustedConnection: true, trustServerCertificate: true }
  },
  {
    server: 'localhost\\SQLEXPRESS',
    database: 'CaseTrack',
    driver: 'msnodesqlv8',
    options: { trustedConnection: true, connectTimeout: 3000 }
  },
  {
    server: 'localhost',
    database: 'CaseTrack',
    driver: 'msnodesqlv8',
    options: { trustedConnection: true, connectTimeout: 3000 }
  },
  {
    server: '127.0.0.1',
    database: 'CaseTrack',
    driver: 'msnodesqlv8',
    options: { trustedConnection: true, connectTimeout: 3000 }
  },
  {
    server: '.',
    database: 'CaseTrack',
    driver: 'msnodesqlv8',
    options: { trustedConnection: true, connectTimeout: 3000 }
  }
];

async function test() {
  for (let i = 0; i < configs.length; i++) {
    console.log(`\nTesting config ${i + 1} (${configs[i].server})...`);
    try {
      // For msnodesqlv8, if default driver fails, we can try to force connectionString
      let pool;
      try {
        pool = await sql.connect(configs[i]);
      } catch (e) {
        if (e.message.includes('Data source name not found')) {
          const str = `Driver={ODBC Driver 17 for SQL Server};Server=${configs[i].server};Database=${configs[i].database};Trusted_Connection=yes;`;
          pool = await sql.connect({ connectionString: str });
        } else throw e;
      }
      console.log(`SUCCESS with config ${i + 1}`);
      await pool.close();
      return;
    } catch (err) {
      console.log(`Failed config ${i + 1}:`, err.message);
    }
  }
}

test();
