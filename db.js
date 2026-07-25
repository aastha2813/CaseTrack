const { Pool } = require('pg');
require('dotenv').config();

const pool = new Pool({
  host: process.env.DB_HOST || 'localhost',
  port: parseInt(process.env.DB_PORT || '5432', 10),
  user: process.env.DB_USER || 'postgres',
  password: process.env.DB_PASSWORD,
  database: process.env.DB_NAME || 'CaseTrack'
});

pool.on('connect', () => {
  console.log('✅ Connected to PostgreSQL Database');
});

pool.on('error', (err) => {
  console.error('❌ PostgreSQL Database Pool Error:', err.message);
});

module.exports = {
  query: (text, params) => pool.query(text, params),
  pool
};
