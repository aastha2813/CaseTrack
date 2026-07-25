const { Pool } = require('pg');
require('dotenv').config();

console.log('--- Environment Check ---');
console.log('DB_HOST:', process.env.DB_HOST);
console.log('DB_PORT:', process.env.DB_PORT);
console.log('DB_USER:', process.env.DB_USER);
console.log('DB_PASSWORD type:', typeof process.env.DB_PASSWORD);
console.log('DB_PASSWORD length:', process.env.DB_PASSWORD ? process.env.DB_PASSWORD.length : 0);
console.log('DB_NAME:', process.env.DB_NAME);

const pool = new Pool({
  host: process.env.DB_HOST || 'localhost',
  port: parseInt(process.env.DB_PORT || '5432', 10),
  user: process.env.DB_USER || 'postgres',
  password: process.env.DB_PASSWORD,
  database: process.env.DB_NAME || 'CaseTrack'
});

async function runTest() {
  try {
    console.log('\nConnecting to database...');
    const res = await pool.query('SELECT NOW()');
    console.log('✅ Connection Success! Server time:', res.rows[0].now);
  } catch (err) {
    console.error('❌ Connection Failed:', err.message);
  } finally {
    await pool.end();
  }
}

runTest();
