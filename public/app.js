/* ─────────────────────────────────────────────────────────────
   CaseTrack – app.js  (Frontend SPA Logic)
   ───────────────────────────────────────────────────────────── */

const API = '/api';

/* ─── State ─── */
let allCases = [];
let filteredCases = [];
let currentPage = 1;
const PAGE_SIZE = 15;

let currentView = 'dashboard';
let currentParam = null;

let socket;
if (typeof io !== 'undefined') {
  socket = io();
  socket.on('db-updated', () => {
    showToast('Database updated externally! Refreshing...', 'success');
    if (currentView === 'dashboard') renderDashboard();
    else if (currentView === 'cases') renderCaseList();
    else if (currentView === 'detail') renderCaseDetail(currentParam);
  });
} else {
  console.warn('Socket.io is not loaded. Real-time updates are disabled.');
}

/* ─── Login Logic ─── */
let currentLoginType = null;

function checkLogin() {
  const isLoggedIn = sessionStorage.getItem('isLoggedIn');
  const navbar = document.getElementById('main-navbar');
  
  if (isLoggedIn === 'true') {
    if (navbar) navbar.style.display = 'flex';
    return true;
  } else {
    if (navbar) navbar.style.display = 'none';
    return false;
  }
}

function renderLoginSelection() {
  const mainContent = document.getElementById('main-content');
  if (!mainContent) return;

  mainContent.innerHTML = `
    <div class="login-container" style="animation:fadeSlideIn .4s ease">
      <div class="login-card">
        <div class="login-logo"><i class="fas fa-balance-scale"></i></div>
        <div class="login-title">CaseTrack</div>
        <div class="login-subtitle">Judicial Case Management</div>
        
        <div class="login-selection-title">Login as:</div>
        
        <div class="login-type-buttons">
          <button class="btn-login-type" onclick="selectLoginType('admin')">ADMIN</button>
          <button class="btn-login-type" onclick="selectLoginType('user')">USER</button>
        </div>
        
        <div style="margin-top: 28px; font-size: 14px;">
          <span style="color: var(--text-secondary);">New user? </span>
          <button class="login-change-type-btn" style="margin-top: 0; text-decoration: underline;" onclick="renderSignupForm()">Sign Up</button>
        </div>
      </div>
    </div>
  `;
}

function selectLoginType(type) {
  currentLoginType = type;
  renderLoginForm(type);
}

function renderLoginForm(type) {
  const mainContent = document.getElementById('main-content');
  if (!mainContent) return;

  const displayTitle = type === 'admin' ? 'Admin Login' : 'User Login';
  const signupOption = type === 'user' ? `
    <div style="margin-top: 18px; font-size: 14px;">
      <span style="color: var(--text-secondary);">Don't have an account? </span>
      <button class="login-change-type-btn" style="margin-top: 0; text-decoration: underline;" onclick="renderSignupForm()">Sign Up</button>
    </div>
  ` : '';

  mainContent.innerHTML = `
    <div class="login-container" style="animation:fadeSlideIn .4s ease">
      <div class="login-card">
        <div class="login-logo"><i class="fas fa-balance-scale"></i></div>
        <div class="login-title">CaseTrack</div>
        <div class="login-subtitle">Judicial Case Management</div>
        
        <div class="login-form-title">${displayTitle}</div>
        
        <div class="login-error" id="login-error-msg">Invalid username or password.</div>
        
        <div class="form-group" style="text-align: left;">
          <label class="form-label">Username</label>
          <input class="form-input" type="text" id="login-username" placeholder="Enter username" onkeydown="handleLoginKey(event)" />
        </div>
        
        <div class="form-group" style="text-align: left;">
          <label class="form-label">Password</label>
          <input class="form-input" type="password" id="login-password" placeholder="Enter password" onkeydown="handleLoginKey(event)" />
        </div>
        
        <button class="btn btn-primary" style="width: 100%; margin-top: 12px; padding: 16px;" onclick="validateCredentials()">LOGIN</button>
        
        <div>
          <button class="login-change-type-btn" onclick="renderLoginSelection()">Change Login Type</button>
        </div>
        
        ${signupOption}
      </div>
    </div>
  `;
  document.getElementById('login-username').focus();
}

function renderSignupForm() {
  const mainContent = document.getElementById('main-content');
  if (!mainContent) return;

  mainContent.innerHTML = `
    <div class="login-container" style="animation:fadeSlideIn .4s ease">
      <div class="login-card" style="max-width: 480px; padding: 40px 36px;">
        <div class="login-logo"><i class="fas fa-balance-scale"></i></div>
        <div class="login-title">CaseTrack</div>
        <div class="login-subtitle">Judicial Case Management</div>
        
        <div class="login-form-title" style="margin-bottom: 20px;">Create User Account</div>
        
        <div class="login-error" id="signup-error-msg"></div>
        
        <div class="form-group" style="text-align: left; margin-bottom: 16px;">
          <label class="form-label">Full Name</label>
          <input class="form-input" type="text" id="signup-fullname" placeholder="Enter full name" />
        </div>
        
        <div class="form-group" style="text-align: left; margin-bottom: 16px;">
          <label class="form-label">Username</label>
          <input class="form-input" type="text" id="signup-username" placeholder="Enter username" />
        </div>
        
        <div class="form-group" style="text-align: left; margin-bottom: 16px;">
          <label class="form-label">Email</label>
          <input class="form-input" type="email" id="signup-email" placeholder="Enter email" />
        </div>
        
        <div class="form-group" style="text-align: left; margin-bottom: 16px;">
          <label class="form-label">Phone</label>
          <input class="form-input" type="text" id="signup-phone" placeholder="Enter phone number" />
        </div>
        
        <div class="form-group" style="text-align: left; margin-bottom: 16px;">
          <label class="form-label">Password</label>
          <input class="form-input" type="password" id="signup-password" placeholder="Enter password" />
        </div>
        
        <div class="form-group" style="text-align: left; margin-bottom: 20px;">
          <label class="form-label">Confirm Password</label>
          <input class="form-input" type="password" id="signup-confirm-password" placeholder="Confirm your password" />
        </div>
        
        <button class="btn btn-primary" style="width: 100%; padding: 16px;" onclick="validateAndSubmitSignup()">Sign Up</button>
        
        <div>
          <button class="login-change-type-btn" style="margin-top: 20px;" onclick="renderLoginSelection()">Back to Login</button>
        </div>
      </div>
    </div>
  `;
  document.getElementById('signup-fullname').focus();
}

function handleLoginKey(event) {
  if (event.key === 'Enter') {
    validateCredentials();
  }
}

async function validateCredentials() {
  const usernameInput = document.getElementById('login-username')?.value.trim();
  const passwordInput = document.getElementById('login-password')?.value;
  const errorMsg = document.getElementById('login-error-msg');

  if (errorMsg) errorMsg.style.display = 'none';

  if (!usernameInput || !passwordInput) {
    if (errorMsg) {
      errorMsg.textContent = 'Username and password are required.';
      errorMsg.style.display = 'block';
    }
    return;
  }

  try {
    const response = await fetch(`${API}/login`, {
      method: 'POST',
      headers: { 'Content-Type': 'application/json' },
      body: JSON.stringify({
        username: usernameInput,
        password: passwordInput,
        role: currentLoginType
      })
    });

    const data = await response.json();
    if (response.ok) {
      sessionStorage.setItem('isLoggedIn', 'true');
      sessionStorage.setItem('userId', data.user_id);
      sessionStorage.setItem('fullName', data.full_name);
      sessionStorage.setItem('username', data.username);
      sessionStorage.setItem('userRole', data.role);
      
      const navbar = document.getElementById('main-navbar');
      if (navbar) navbar.style.display = 'flex';
      
      showToast(`Welcome back, ${data.full_name}!`, 'success');
      navigate('dashboard');
    } else {
      if (errorMsg) {
        errorMsg.textContent = data.error || 'Invalid username or password.';
        errorMsg.style.display = 'block';
      }
    }
  } catch (err) {
    if (errorMsg) {
      errorMsg.textContent = 'Server error. Please try again.';
      errorMsg.style.display = 'block';
    }
  }
}

async function validateAndSubmitSignup() {
  const fullname = document.getElementById('signup-fullname')?.value.trim();
  const username = document.getElementById('signup-username')?.value.trim();
  const email = document.getElementById('signup-email')?.value.trim();
  const phone = document.getElementById('signup-phone')?.value.trim();
  const password = document.getElementById('signup-password')?.value;
  const confirmPassword = document.getElementById('signup-confirm-password')?.value;
  const errorMsg = document.getElementById('signup-error-msg');

  if (errorMsg) errorMsg.style.display = 'none';

  // Frontend validations
  if (!fullname || !username || !email || !phone || !password || !confirmPassword) {
    showSignupError('All fields are required.');
    return;
  }

  if (password !== confirmPassword) {
    showSignupError('Password and Confirm Password do not match.');
    return;
  }

  try {
    const response = await fetch(`${API}/signup`, {
      method: 'POST',
      headers: { 'Content-Type': 'application/json' },
      body: JSON.stringify({
        full_name: fullname,
        username,
        email,
        phone,
        password,
        confirmPassword
      })
    });

    const data = await response.json();
    if (response.ok) {
      showToast('Account created successfully. Please login.', 'success');
      // Go to User Login screen automatically
      selectLoginType('user');
    } else {
      showSignupError(data.error || 'Signup failed.');
    }
  } catch (err) {
    showSignupError('Server error. Please try again.');
  }
}

function showSignupError(msg) {
  const errorMsg = document.getElementById('signup-error-msg');
  if (errorMsg) {
    errorMsg.textContent = msg;
    errorMsg.style.display = 'block';
  }
}

function logout() {
  sessionStorage.clear();
  checkLogin();
  renderLoginSelection();
  showToast('Logged out successfully', 'success');
}

/* ─── Init ─── */
window.addEventListener('DOMContentLoaded', () => {
  initTheme();
  startClock();
  if (checkLogin()) {
    navigate('dashboard');
  } else {
    renderLoginSelection();
  }
});

/* ─── Theme ─── */
function initTheme() {
  const saved = localStorage.getItem('theme') || 'light';
  if (saved === 'dark') document.body.setAttribute('data-theme', 'dark');
  updateThemeIcon(saved === 'dark');
}

function toggleTheme() {
  const isDark = document.body.getAttribute('data-theme') === 'dark';
  if (isDark) {
    document.body.removeAttribute('data-theme');
    localStorage.setItem('theme', 'light');
    updateThemeIcon(false);
  } else {
    document.body.setAttribute('data-theme', 'dark');
    localStorage.setItem('theme', 'dark');
    updateThemeIcon(true);
  }
}

function updateThemeIcon(isDark) {
  const iconSpan = document.getElementById('theme-icon');
  if (iconSpan) {
    iconSpan.innerHTML = isDark ? '<i class="fas fa-sun"></i>' : '<i class="fas fa-moon"></i>';
  }
}

/* ─── Clock ─── */
function startClock() {
  const el = document.getElementById('nav-clock');
  function tick() {
    const now = new Date();
    el.textContent = now.toLocaleTimeString('en-IN', { hour: '2-digit', minute: '2-digit', second: '2-digit' });
  }
  tick();
  setInterval(tick, 1000);
}

/* ─── Navigation ─── */
function navigate(view, param) {
  if (!checkLogin()) {
    renderLoginSelection();
    return;
  }
  currentView = view;
  currentParam = param;
  document.querySelectorAll('.nav-btn').forEach(b => b.classList.remove('active'));
  const btn = document.getElementById('nav-' + view);
  if (btn) btn.classList.add('active');

  closeModal();

  switch (view) {
    case 'dashboard': renderDashboard(); break;
    case 'cases':     renderCaseList(); break;
    case 'detail':    renderCaseDetail(param); break;
    case 'add':       renderAddCase(); break;
  }
}

/* ─── Toast ─── */
function showToast(msg, type = '') {
  const t = document.getElementById('toast');
  t.textContent = msg;
  t.className = 'toast show ' + type;
  clearTimeout(t._timer);
  t._timer = setTimeout(() => { t.className = 'toast'; }, 3500);
}

/* ─── Modal ─── */
function openModal(html) {
  document.getElementById('modal-content').innerHTML = html;
  document.getElementById('modal-overlay').classList.add('open');
}
function closeModal() {
  document.getElementById('modal-overlay').classList.remove('open');
}

/* ─── Helpers ─── */
function statusBadge(status) {
  const s = (status || '').toLowerCase().replace(/\s+/g, '-');
  if (s.includes('open'))   return `<span class="badge badge-open"><span class="badge-dot"></span>${status}</span>`;
  if (s.includes('closed')) return `<span class="badge badge-closed"><span class="badge-dot"></span>${status}</span>`;
  return `<span class="badge badge-investigation"><span class="badge-dot"></span>${status}</span>`;
}

function crimeBadge(type) {
  const map = {
    'Theft': 'theft', 'Fraud': 'fraud', 'Cybercrime': 'cyber',
    'Robbery': 'robbery', 'Assault': 'assault', 'Murder': 'murder'
  };
  const cls = map[type] || 'default';
  return `<span class="badge badge-crime-${cls}">${type || '—'}</span>`;
}

function suspicionSpan(level) {
  const cls = `suspicion-${(level || '').toLowerCase()}`;
  return `<span class="${cls}">${level || '—'}</span>`;
}

function setMain(html) {
  document.getElementById('main-content').innerHTML = html;
}

/* ═══════════════════════════════════════════════════════
   DASHBOARD
   ═══════════════════════════════════════════════════════ */
async function renderDashboard() {
  setMain(`<div class="spinner-wrap"><div class="spinner"></div><div class="spinner-text">Loading dashboard…</div></div>`);
  try {
    const headers = {
      'x-user-id': sessionStorage.getItem('userId') || '',
      'x-user-role': sessionStorage.getItem('userRole') || ''
    };
    const [stats, cases] = await Promise.all([
      fetch(`${API}/dashboard`, { headers }).then(r => r.json()),
      fetch(`${API}/cases`, { headers }).then(r => r.json())
    ]);

    const recentCases = [...cases].sort((a, b) => {
      return parseDateStr(b.Start_Date) - parseDateStr(a.Start_Date);
    }).slice(0, 8);

    const maxCrime = Math.max(...Object.values(stats.crimeTypeCounts || {}), 1);

    const barRows = Object.entries(stats.crimeTypeCounts || {})
      .sort((a, b) => b[1] - a[1])
      .map(([type, count]) => `
        <div class="bar-item">
          <span class="bar-label">${type}</span>
          <div class="bar-track"><div class="bar-fill" style="width:${(count/maxCrime*100).toFixed(1)}%"></div></div>
          <span class="bar-count">${count}</span>
        </div>`).join('');

    // SVG Donut
    const donutData = [
      { label: 'Open', count: stats.open, color: '#22c55e' },
      { label: 'Closed', count: stats.closed, color: '#ef4444' },
      { label: 'Under Investigation', count: stats.underInvestigation, color: '#f59e0b' },
    ];
    const donutSVG = buildDonut(donutData, stats.total);

    const recentRows = recentCases.map(c => `
      <tr>
        <td><span class="case-id-chip">${c.Case_Id}</span></td>
        <td style="font-weight:600;color:var(--text-primary)">${c.Title}</td>
        <td>${crimeBadge(c.Crime_Type)}</td>
        <td>${statusBadge(c.Status)}</td>
        <td style="color:var(--text-muted)">${c.Start_Date}</td>
        <td>
          <button class="btn btn-sm btn-secondary" onclick="navigate('detail','${c.Case_Id}')">View →</button>
        </td>
      </tr>`).join('');

    setMain(`
      <div class="page-header" style="animation:fadeSlideIn .4s ease">
        <h1 class="page-title"><i class="fas fa-chart-line" style="margin-right:12px;color:var(--primary)"></i> Dashboard</h1>
        <p class="page-subtitle">Overview of all judicial cases in the system</p>
      </div>

      <div class="stats-grid">
        <div class="stat-card" style="animation-delay:.05s">
          <div class="stat-icon blue"><i class="fas fa-folder-open"></i></div>
          <div><div class="stat-value">${stats.total}</div><div class="stat-label">Total Cases</div></div>
        </div>
        <div class="stat-card" style="animation-delay:.1s">
          <div class="stat-icon green"><i class="fas fa-check-circle"></i></div>
          <div><div class="stat-value">${stats.open}</div><div class="stat-label">Open Cases</div></div>
        </div>
        <div class="stat-card" style="animation-delay:.15s">
          <div class="stat-icon red"><i class="fas fa-times-circle"></i></div>
          <div><div class="stat-value">${stats.closed}</div><div class="stat-label">Closed Cases</div></div>
        </div>
        <div class="stat-card" style="animation-delay:.2s">
          <div class="stat-icon amber"><i class="fas fa-search"></i></div>
          <div><div class="stat-value">${stats.underInvestigation}</div><div class="stat-label">Under Investigation</div></div>
        </div>
      </div>

      <div class="charts-row">
        <div class="chart-card">
          <div class="chart-title">Cases by Crime Type</div>
          <div class="bar-chart">${barRows}</div>
        </div>
        <div class="chart-card">
          <div class="chart-title">Case Status Distribution</div>
          <div class="donut-wrap">
            ${donutSVG}
            <div class="donut-legend">
              ${donutData.map(d => `
                <div class="legend-item">
                  <div class="legend-dot" style="background:${d.color}"></div>
                  <span class="legend-text">${d.label}</span>
                  <span class="legend-num">${d.count}</span>
                </div>`).join('')}
            </div>
          </div>
        </div>
      </div>

      <div class="section-header">
        <span class="section-title">Recent Cases</span>
        <button class="btn btn-secondary btn-sm" onclick="navigate('cases')">View All →</button>
      </div>
      <div class="table-wrapper">
        <table class="data-table">
          <thead>
            <tr>
              <th>Case ID</th><th>Title</th><th>Crime Type</th>
              <th>Status</th><th>Date</th><th>Action</th>
            </tr>
          </thead>
          <tbody>${recentRows}</tbody>
        </table>
      </div>
    `);
  } catch (err) {
    setMain(`<div class="empty-state"><div class="empty-state-icon"><i class="fas fa-exclamation-triangle"></i></div><p>Failed to load dashboard. Is the server running?</p></div>`);
  }
}

/* Build SVG donut */
function buildDonut(data, total) {
  const R = 52, C = 2 * Math.PI * R;
  let offset = 0;
  let slices = '';
  data.forEach(d => {
    const pct = total === 0 ? 0 : d.count / total;
    const dash = pct * C;
    slices += `<circle cx="64" cy="64" r="${R}" fill="none" stroke="${d.color}" stroke-width="20"
      stroke-dasharray="${dash} ${C - dash}" stroke-dashoffset="${-offset}" style="transition:stroke-dasharray .8s ease"/>`;
    offset += dash;
  });
  return `<svg class="donut-svg" width="128" height="128" viewBox="0 0 128 128">
    <circle cx="64" cy="64" r="${R}" fill="none" stroke="#f1f5f9" stroke-width="20"/>
    ${slices}
    <text x="64" y="64" text-anchor="middle" dominant-baseline="central" font-size="20" font-weight="800" fill="#0f172a">${total}</text>
  </svg>`;
}

function parseDateStr(s) {
  if (!s) return 0;
  const parts = s.split('-');
  if (parts.length !== 3) return 0;
  const [d, m, y] = parts;
  return new Date(`${y}-${m}-${d}`).getTime() || 0;
}

/* ═══════════════════════════════════════════════════════
   CASE LIST PAGE
   ═══════════════════════════════════════════════════════ */
async function renderCaseList() {
  setMain(`<div class="spinner-wrap"><div class="spinner"></div><div class="spinner-text">Loading cases…</div></div>`);
  try {
    const headers = {
      'x-user-id': sessionStorage.getItem('userId') || '',
      'x-user-role': sessionStorage.getItem('userRole') || ''
    };
    allCases = await fetch(`${API}/cases`, { headers }).then(r => r.json());
    filteredCases = [...allCases];
    currentPage = 1;
    setMain(`
      <div class="page-header">
        <h1 class="page-title"><i class="fas fa-folder-open" style="margin-right:12px;color:var(--primary)"></i> All Cases</h1>
        <p class="page-subtitle">${allCases.length} cases in the system</p>
      </div>

      <div class="search-bar">
        <input class="search-input" id="case-search" placeholder="Search by Case ID, title, or crime type…"
          oninput="filterCases()" />
        <select class="filter-select" id="status-filter" onchange="filterCases()">
          <option value="">All Statuses</option>
          <option>Open</option>
          <option>Closed</option>
          <option>Under Investigation</option>
        </select>
        <select class="filter-select" id="crime-filter" onchange="filterCases()">
          <option value="">All Crime Types</option>
          <option>Theft</option>
          <option>Fraud</option>
          <option>Cybercrime</option>
          <option>Robbery</option>
          <option>Assault</option>
          <option>Murder</option>
        </select>
        <button class="btn btn-primary btn-sm" onclick="navigate('add')">+ Add Case</button>
      </div>

      <div id="cases-table-wrap"></div>
    `);
    renderCasesTable();
  } catch (err) {
    setMain(`<div class="empty-state"><div class="empty-state-icon"><i class="fas fa-exclamation-triangle"></i></div><p>Failed to load cases.</p></div>`);
  }
}

function filterCases() {
  const q = (document.getElementById('case-search')?.value || '').toLowerCase();
  const status = document.getElementById('status-filter')?.value || '';
  const crime  = document.getElementById('crime-filter')?.value  || '';

  filteredCases = allCases.filter(c => {
    const matchQ = !q || c.Case_Id.toLowerCase().includes(q) ||
      (c.Title || '').toLowerCase().includes(q) ||
      (c.Crime_Type || '').toLowerCase().includes(q);
    const matchS = !status || c.Status === status;
    const matchC = !crime  || c.Crime_Type === crime;
    return matchQ && matchS && matchC;
  });
  currentPage = 1;
  renderCasesTable();
}

function renderCasesTable() {
  const wrap = document.getElementById('cases-table-wrap');
  if (!wrap) return;

  if (filteredCases.length === 0) {
    wrap.innerHTML = `<div class="empty-state"><div class="empty-state-icon"><i class="fas fa-search"></i></div><p>No cases match your search.</p></div>`;
    return;
  }

  const total = filteredCases.length;
  const pages = Math.ceil(total / PAGE_SIZE);
  const start = (currentPage - 1) * PAGE_SIZE;
  const pageData = filteredCases.slice(start, start + PAGE_SIZE);

  const rows = pageData.map(c => `
    <tr>
      <td><span class="case-id-chip">${c.Case_Id}</span></td>
      <td style="font-weight:600;color:var(--text-primary);max-width:240px">${c.Title}</td>
      <td style="max-width:200px;color:var(--text-muted);font-size:12px">${c.Description ? c.Description.substring(0,60)+'…' : '—'}</td>
      <td>${crimeBadge(c.Crime_Type)}</td>
      <td>${statusBadge(c.Status)}</td>
      <td style="color:var(--text-muted)">${c.Start_Date}</td>
      <td>
        <button class="btn btn-sm btn-primary" onclick="navigate('detail','${c.Case_Id}')">View</button>
      </td>
    </tr>`).join('');

  const paginBtns = buildPagination(currentPage, pages);

  wrap.innerHTML = `
    <div class="table-wrapper">
      <table class="data-table">
        <thead>
          <tr>
            <th>Case ID</th><th>Title</th><th>Description</th>
            <th>Crime Type</th><th>Status</th><th>Date Filed</th><th>Action</th>
          </tr>
        </thead>
        <tbody>${rows}</tbody>
      </table>
    </div>
    <div style="display:flex;align-items:center;justify-content:space-between;padding:12px 4px;font-size:12.5px;color:var(--text-muted)">
      <span>Showing ${start+1}–${Math.min(start+PAGE_SIZE,total)} of ${total} cases</span>
      <div class="pagination">${paginBtns}</div>
    </div>`;
}

function buildPagination(current, total) {
  if (total <= 1) return '';
  let html = `<button class="page-btn" ${current===1?'disabled':''} onclick="gotoPage(${current-1})">‹</button>`;
  const pages = [];
  if (total <= 7) {
    for (let i=1; i<=total; i++) pages.push(i);
  } else {
    pages.push(1);
    if (current > 3) pages.push('…');
    for (let i=Math.max(2,current-1); i<=Math.min(total-1,current+1); i++) pages.push(i);
    if (current < total-2) pages.push('…');
    pages.push(total);
  }
  pages.forEach(p => {
    if (p === '…') html += `<button class="page-btn" disabled>…</button>`;
    else html += `<button class="page-btn ${p===current?'active':''}" onclick="gotoPage(${p})">${p}</button>`;
  });
  html += `<button class="page-btn" ${current===total?'disabled':''} onclick="gotoPage(${current+1})">›</button>`;
  return html;
}

function gotoPage(p) {
  currentPage = p;
  renderCasesTable();
  window.scrollTo({ top: 0, behavior: 'smooth' });
}

/* ═══════════════════════════════════════════════════════
   CASE DETAIL PAGE
   ═══════════════════════════════════════════════════════ */
async function renderCaseDetail(caseId) {
  setMain(`<div class="spinner-wrap"><div class="spinner"></div><div class="spinner-text">Loading case details…</div></div>`);
  try {
    const headers = {
      'x-user-id': sessionStorage.getItem('userId') || '',
      'x-user-role': sessionStorage.getItem('userRole') || ''
    };
    const d = await fetch(`${API}/cases/${caseId}/details`, { headers }).then(r => r.json());
    if (d.error) { setMain(`<div class="empty-state"><div class="empty-state-icon"><i class="fas fa-times-circle"></i></div><p>${d.error}</p></div>`); return; }

    const c = d.case;

    /* Crime scene */
    const sceneHTML = d.crimeScene ? `
      <div class="info-grid">
        <div class="info-item"><div class="info-label">Scene ID</div><div class="info-value">${d.crimeScene.Scene_id||'—'}</div></div>
        <div class="info-item"><div class="info-label">Date Reported</div><div class="info-value">${d.crimeScene.Date_Reported||'—'}</div></div>
        <div class="info-item"><div class="info-label">City</div><div class="info-value">${d.crimeScene.City||'—'}</div></div>
        <div class="info-item"><div class="info-label">Address</div><div class="info-value">${d.crimeScene.Address||'—'}</div></div>
        <div class="info-item" style="grid-column:1/-1"><div class="info-label">Description</div><div class="info-value">${d.crimeScene.Description||'—'}</div></div>
      </div>` : `<div class="empty-state"><div class="empty-state-icon"><i class="fas fa-map-marker-alt"></i></div><p>No crime scene recorded.</p></div>`;

    /* Judge */
    const judgeHTML = d.judge ? `
      <div class="info-grid">
        <div class="info-item"><div class="info-label">Judge ID</div><div class="info-value">${d.judge.Judge_Id||'—'}</div></div>
        <div class="info-item"><div class="info-label">Name</div><div class="info-value" style="font-weight:700">${d.judge.Judge_Name||'—'}</div></div>
        <div class="info-item"><div class="info-label">Court</div><div class="info-value">${d.judge.Court_Name||'—'}</div></div>
      </div>` : `<div class="empty-state"><div class="empty-state-icon"><i class="fas fa-balance-scale"></i></div><p>No judge assigned.</p></div>`;

    /* Verdict */
    const verdictHTML = d.verdict ? `
      <div class="info-grid">
        <div class="info-item"><div class="info-label">Verdict ID</div><div class="info-value">${d.verdict.Verdict_Id||'—'}</div></div>
        <div class="info-item"><div class="info-label">Decision</div><div class="info-value" style="font-weight:700;color:var(--primary)">${d.verdict.Decision||'—'}</div></div>
        <div class="info-item"><div class="info-label">Date</div><div class="info-value">${d.verdict.Date||'—'}</div></div>
        <div class="info-item" style="grid-column:1/-1"><div class="info-label">Remarks</div><div class="info-value">${d.verdict.Remarks||'—'}</div></div>
      </div>` : `<div class="empty-state"><div class="empty-state-icon"><i class="fas fa-scroll"></i></div><p>No verdict recorded.</p></div>`;

    /* Officers */
    const officersHTML = d.officers.length ? `
      <table class="mini-table">
        <thead><tr><th>ID</th><th>Name</th><th>Rank</th><th>Dept</th><th>Role</th></tr></thead>
        <tbody>${d.officers.map(o => `<tr>
          <td style="font-family:monospace;font-size:11px"><span class="case-id-chip">${o.Officer_Id||'—'}</span></td>
          <td style="font-weight:600">${o.Name||'—'}</td>
          <td>${o.Officer_Rank||'—'}</td>
          <td>${o.Department||'—'}</td>
          <td><span style="color:var(--primary);font-weight:600">${o.Role_In_Case||'—'}</span></td>
        </tr>`).join('')}</tbody>
      </table>` : `<div class="empty-state"><div class="empty-state-icon"><i class="fas fa-user-shield"></i></div><p>No officers assigned.</p></div>`;

    /* Suspects */
    const suspectsHTML = d.suspects.length ? `
      <table class="mini-table">
        <thead><tr><th>ID</th><th>Name</th><th>DOB</th><th>Gender</th><th>History</th><th>Suspicion</th><th>Role</th></tr></thead>
        <tbody>${d.suspects.map(s => `<tr>
          <td style="font-family:monospace;font-size:11px">${s.Suspect_Id||'—'}</td>
          <td style="font-weight:600">${s.Name||'—'}</td>
          <td>${s.DOB||'—'}</td>
          <td>${s.Gender||'—'}</td>
          <td style="font-size:11px">${s.Criminal_History||'—'}</td>
          <td>${suspicionSpan(s.Suspicion_Level)}</td>
          <td style="font-size:11px">${s.Role_In_Case||'—'}</td>
        </tr>`).join('')}</tbody>
      </table>` : `<div class="empty-state"><div class="empty-state-icon"><i class="fas fa-user-secret"></i></div><p>No suspects recorded.</p></div>`;

    /* Evidence */
    const evidenceHTML = d.evidence.length ? `
      <table class="mini-table">
        <thead><tr><th>ID</th><th>Type</th><th>Description</th><th>Storage</th></tr></thead>
        <tbody>${d.evidence.map(e => `<tr>
          <td style="font-family:monospace;font-size:11px">${e.Evidence_Id||'—'}</td>
          <td><span class="badge badge-crime-default">${e.Type||'—'}</span></td>
          <td>${e.Description||'—'}</td>
          <td style="color:var(--text-muted)">${e.Storage_Location||'—'}</td>
        </tr>`).join('')}</tbody>
      </table>` : `<div class="empty-state"><div class="empty-state-icon"><i class="fas fa-microscope"></i></div><p>No evidence recorded.</p></div>`;

    /* Clues */
    const cluesHTML = d.clues.length ? `
      <table class="mini-table">
        <thead><tr><th>ID</th><th>Description</th><th>Date</th><th>Location</th></tr></thead>
        <tbody>${d.clues.map(cl => `<tr>
          <td style="font-family:monospace;font-size:11px">${cl.Clue_Id||'—'}</td>
          <td>${cl.Description||'—'}</td>
          <td>${cl.Discovered_Date||'—'}</td>
          <td style="color:var(--text-muted)">${cl.Location||'—'}</td>
        </tr>`).join('')}</tbody>
      </table>` : `<div class="empty-state"><div class="empty-state-icon"><i class="fas fa-lightbulb"></i></div><p>No clues recorded.</p></div>`;

    /* Advocates */
    const advocatesHTML = d.advocates.length ? `
      <table class="mini-table">
        <thead><tr><th>Advocate</th><th>Role</th><th>Experience</th></tr></thead>
        <tbody>${d.advocates.map(a => `<tr>
          <td style="font-weight:600">${a.Advocate_Name||'—'}</td>
          <td><span style="color:${a.Role==='Prosecution'?'var(--danger)':'var(--success)'};font-weight:700">${a.Role||'—'}</span></td>
          <td>${a.Experience_Years||'—'} yrs</td>
        </tr>`).join('')}</tbody>
      </table>` : `<div class="empty-state"><div class="empty-state-icon"><i class="fas fa-user-tie"></i></div><p>No advocates assigned.</p></div>`;

    setMain(`
      <button class="back-btn" onclick="navigate('cases')">← Back to Cases</button>

      <div class="detail-header">
        <div class="detail-case-id">CASE ${c.Case_Id}</div>
        <div class="detail-title">${c.Title}</div>
        <div class="detail-desc">${c.Description}</div>
        <div class="detail-meta">
          <div class="detail-meta-item">
            <span class="detail-meta-label">Status</span>
            <span class="detail-meta-value">${c.Status}</span>
          </div>
          <div class="detail-meta-item">
            <span class="detail-meta-label">Crime Type</span>
            <span class="detail-meta-value">${c.Crime_Type}</span>
          </div>
          <div class="detail-meta-item">
            <span class="detail-meta-label">Filed On</span>
            <span class="detail-meta-value">${c.Start_Date}</span>
          </div>
          <div class="detail-meta-item">
            <span class="detail-meta-label">Suspects</span>
            <span class="detail-meta-value">${d.suspects.length}</span>
          </div>
          <div class="detail-meta-item">
            <span class="detail-meta-label">Evidence</span>
            <span class="detail-meta-value">${d.evidence.length}</span>
          </div>
        </div>

        <!-- Status update -->
        <div class="status-update-row">
          <span style="font-size:12px;font-weight:700;opacity:0.85;white-space:nowrap">Update Status:</span>
          <select id="status-select-${c.Case_Id}">
            <option ${c.Status==='Open'?'selected':''}>Open</option>
            <option ${c.Status==='Closed'?'selected':''}>Closed</option>
            <option ${c.Status==='Under Investigation'?'selected':''}>Under Investigation</option>
          </select>
          <button class="btn btn-sm" style="background:white;color:var(--primary);font-weight:700"
            onclick="updateStatus('${c.Case_Id}')">Save</button>
        </div>
      </div>

      <div class="detail-grid">
        <!-- Crime Scene -->
        <div class="detail-section">
          <div class="detail-section-title"><i class="fas fa-map-marker-alt"></i> Crime Scene</div>
          ${sceneHTML}
        </div>

        <!-- Verdict -->
        <div class="detail-section">
          <div class="detail-section-title"><i class="fas fa-scroll"></i> Verdict</div>
          ${verdictHTML}
        </div>

        <!-- Judge -->
        <div class="detail-section">
          <div class="detail-section-title"><i class="fas fa-balance-scale"></i> Presiding Judge
            <button class="btn btn-sm btn-secondary" style="margin-left:auto" onclick="openAssignJudge('${c.Case_Id}')">Assign</button>
          </div>
          ${judgeHTML}
        </div>

        <!-- Advocates -->
        <div class="detail-section">
          <div class="detail-section-title"><i class="fas fa-user-tie"></i> Advocates
            <button class="btn btn-sm btn-secondary" style="margin-left:auto" onclick="openAssignAdvocate('${c.Case_Id}')">Add</button>
          </div>
          ${advocatesHTML}
        </div>

        <!-- Officers -->
        <div class="detail-section full">
          <div class="detail-section-title"><i class="fas fa-user-shield"></i> Assigned Officers</div>
          ${officersHTML}
        </div>

        <!-- Suspects -->
        <div class="detail-section full">
          <div class="detail-section-title"><i class="fas fa-user-secret"></i> Suspects
            <button class="btn btn-sm btn-secondary" style="margin-left:auto" onclick="openAddSuspect('${c.Case_Id}')">Add Suspect</button>
          </div>
          ${suspectsHTML}
        </div>

        <!-- Evidence -->
        <div class="detail-section full">
          <div class="detail-section-title"><i class="fas fa-microscope"></i> Evidence
            <button class="btn btn-sm btn-secondary" style="margin-left:auto" onclick="openAddEvidence('${c.Case_Id}')">Add Evidence</button>
          </div>
          ${evidenceHTML}
        </div>

        <!-- Clues -->
        <div class="detail-section full">
          <div class="detail-section-title"><i class="fas fa-lightbulb"></i> Clues</div>
          ${cluesHTML}
        </div>
      </div>
    `);
  } catch (err) {
    console.error(err);
    setMain(`<div class="empty-state"><div class="empty-state-icon">⚠️</div><p>Failed to load case details.</p></div>`);
  }
}

/* ─── Update Status ─── */
async function updateStatus(caseId) {
  const sel = document.getElementById(`status-select-${caseId}`);
  if (!sel) return;
  const newStatus = sel.value;
  try {
    const r = await fetch(`${API}/cases/${caseId}/status`, {
      method: 'PATCH',
      headers: { 'Content-Type': 'application/json' },
      body: JSON.stringify({ status: newStatus })
    });
    const data = await r.json();
    if (r.ok) {
      showToast(`✅ Status updated to "${newStatus}"`, 'success');
      setTimeout(() => navigate('detail', caseId), 600);
    } else {
      showToast('❌ ' + (data.error || 'Update failed'), 'error');
    }
  } catch {
    showToast('❌ Server error', 'error');
  }
}

/* ─── Add Suspect Modal ─── */
function openAddSuspect(caseId) {
  openModal(`
    <div class="modal-title"><i class="fas fa-user-secret"></i> Add Suspect</div>
    <div class="modal-subtitle">Case: <strong>${caseId}</strong></div>
    <div class="form-group">
      <label class="form-label">Full Name</label>
      <input class="form-input" id="m-s-name" placeholder="Suspect Name" />
    </div>
    <div class="form-row">
      <div class="form-group">
        <label class="form-label">Date of Birth</label>
        <input class="form-input" id="m-s-dob" placeholder="DD-MM-YYYY" />
      </div>
      <div class="form-group">
        <label class="form-label">Gender</label>
        <select class="form-select" id="m-s-gender">
          <option>Male</option><option>Female</option><option>Other</option>
        </select>
      </div>
    </div>
    <div class="form-group">
      <label class="form-label">Criminal History</label>
      <select class="form-select" id="m-s-history">
        <option>No prior record</option>
        <option>First-time suspect</option>
        <option>Previous theft charges</option>
        <option>Repeat offender</option>
        <option>Fraud investigation history</option>
      </select>
    </div>
    <div class="form-row">
      <div class="form-group">
        <label class="form-label">Suspicion Level</label>
        <select class="form-select" id="m-s-level">
          <option>Low</option><option>Medium</option><option>High</option>
        </select>
      </div>
      <div class="form-group">
        <label class="form-label">Role in Case</label>
        <select class="form-select" id="m-s-role">
          <option>Main Suspect</option><option>Accomplice</option><option>Witness Turned Suspect</option>
        </select>
      </div>
    </div>
    <div class="form-actions">
      <button class="btn btn-primary" onclick="submitSuspect('${caseId}')">Add Suspect</button>
      <button class="btn btn-secondary" onclick="closeModal()">Cancel</button>
    </div>
  `);
}

async function submitSuspect(caseId) {
  const body = {
    Name: document.getElementById('m-s-name').value,
    DOB: document.getElementById('m-s-dob').value,
    Gender: document.getElementById('m-s-gender').value,
    Criminal_History: document.getElementById('m-s-history').value,
    Suspicion_Level: document.getElementById('m-s-level').value,
    Role_In_Case: document.getElementById('m-s-role').value
  };
  try {
    const r = await fetch(`${API}/cases/${caseId}/suspect`, {
      method: 'POST', headers: { 'Content-Type': 'application/json' }, body: JSON.stringify(body)
    });
    const data = await r.json();
    closeModal();
    if (r.ok) { showToast('✅ Suspect added!', 'success'); setTimeout(() => navigate('detail', caseId), 600); }
    else showToast('❌ ' + (data.error || 'Error'), 'error');
  } catch { showToast('❌ Server error', 'error'); }
}

/* ─── Add Evidence Modal ─── */
function openAddEvidence(caseId) {
  openModal(`
    <div class="modal-title"><i class="fas fa-microscope"></i> Add Evidence</div>
    <div class="modal-subtitle">Case: <strong>${caseId}</strong></div>
    <div class="form-group">
      <label class="form-label">Evidence Type</label>
      <select class="form-select" id="m-e-type">
        <option>Physical</option><option>Digital</option><option>Biological</option><option>Documentary</option>
      </select>
    </div>
    <div class="form-group">
      <label class="form-label">Description</label>
      <input class="form-input" id="m-e-desc" placeholder="Brief description…" />
    </div>
    <div class="form-group">
      <label class="form-label">Storage Location</label>
      <select class="form-select" id="m-e-storage">
        <option>Evidence Room 1</option><option>Evidence Room 2</option>
        <option>Forensic Lab</option><option>Locker A</option>
        <option>Locker B</option><option>Locker C</option><option>Locker D</option>
      </select>
    </div>
    <div class="form-actions">
      <button class="btn btn-primary" onclick="submitEvidence('${caseId}')">Add Evidence</button>
      <button class="btn btn-secondary" onclick="closeModal()">Cancel</button>
    </div>
  `);
}

async function submitEvidence(caseId) {
  const body = {
    Type: document.getElementById('m-e-type').value,
    Description: document.getElementById('m-e-desc').value,
    Storage_Location: document.getElementById('m-e-storage').value
  };
  try {
    const r = await fetch(`${API}/cases/${caseId}/evidence`, {
      method: 'POST', headers: { 'Content-Type': 'application/json' }, body: JSON.stringify(body)
    });
    const data = await r.json();
    closeModal();
    if (r.ok) { showToast('✅ Evidence added!', 'success'); setTimeout(() => navigate('detail', caseId), 600); }
    else showToast('❌ ' + (data.error || 'Error'), 'error');
  } catch { showToast('❌ Server error', 'error'); }
}

/* ─── Assign Judge Modal ─── */
function openAssignJudge(caseId) {
  openModal(`
    <div class="modal-title"><i class="fas fa-balance-scale"></i> Assign Judge</div>
    <div class="modal-subtitle">Case: <strong>${caseId}</strong></div>
    <div class="form-group">
      <label class="form-label">Judge Name</label>
      <input class="form-input" id="m-j-name" placeholder="Judge's full name" />
    </div>
    <div class="form-group">
      <label class="form-label">Court Name</label>
      <select class="form-select" id="m-j-court">
        <option>District Court</option><option>Sessions Court</option><option>High Court</option><option>Supreme Court</option>
      </select>
    </div>
    <div class="form-actions">
      <button class="btn btn-primary" onclick="submitJudge('${caseId}')">Assign Judge</button>
      <button class="btn btn-secondary" onclick="closeModal()">Cancel</button>
    </div>
  `);
}

async function submitJudge(caseId) {
  const body = {
    Judge_Name: document.getElementById('m-j-name').value,
    Court_Name: document.getElementById('m-j-court').value
  };
  try {
    const r = await fetch(`${API}/cases/${caseId}/judge`, {
      method: 'POST', headers: { 'Content-Type': 'application/json' }, body: JSON.stringify(body)
    });
    const data = await r.json();
    closeModal();
    if (r.ok) { showToast('✅ Judge assigned!', 'success'); setTimeout(() => navigate('detail', caseId), 600); }
    else showToast('❌ ' + (data.error || 'Error'), 'error');
  } catch { showToast('❌ Server error', 'error'); }
}

/* ─── Assign Advocate Modal ─── */
function openAssignAdvocate(caseId) {
  openModal(`
    <div class="modal-title"><i class="fas fa-user-tie"></i> Add Advocate</div>
    <div class="modal-subtitle">Case: <strong>${caseId}</strong></div>
    <div class="form-group">
      <label class="form-label">Advocate Name</label>
      <input class="form-input" id="m-a-name" placeholder="Advocate's full name" />
    </div>
    <div class="form-row">
      <div class="form-group">
        <label class="form-label">Role</label>
        <select class="form-select" id="m-a-role">
          <option>Prosecution</option><option>Defense</option>
        </select>
      </div>
      <div class="form-group">
        <label class="form-label">Experience (Years)</label>
        <input class="form-input" id="m-a-exp" type="number" min="0" placeholder="Years" />
      </div>
    </div>
    <div class="form-actions">
      <button class="btn btn-primary" onclick="submitAdvocate('${caseId}')">Add Advocate</button>
      <button class="btn btn-secondary" onclick="closeModal()">Cancel</button>
    </div>
  `);
}

async function submitAdvocate(caseId) {
  const body = {
    Advocate_Name: document.getElementById('m-a-name').value,
    Role: document.getElementById('m-a-role').value,
    Experience_Years: document.getElementById('m-a-exp').value
  };
  try {
    const r = await fetch(`${API}/cases/${caseId}/advocate`, {
      method: 'POST', headers: { 'Content-Type': 'application/json' }, body: JSON.stringify(body)
    });
    const data = await r.json();
    closeModal();
    if (r.ok) { showToast('✅ Advocate added!', 'success'); setTimeout(() => navigate('detail', caseId), 600); }
    else showToast('❌ ' + (data.error || 'Error'), 'error');
  } catch { showToast('❌ Server error', 'error'); }
}

/* ═══════════════════════════════════════════════════════
   ADD CASE FORM
   ═══════════════════════════════════════════════════════ */
function renderAddCase() {
  document.querySelectorAll('.nav-btn').forEach(b => b.classList.remove('active'));
  document.getElementById('nav-add')?.classList.add('active');

  const today = new Date();
  const dd = String(today.getDate()).padStart(2, '0');
  const mm = String(today.getMonth() + 1).padStart(2, '0');
  const yyyy = today.getFullYear();
  const dateVal = `${dd}-${mm}-${yyyy}`;

  setMain(`
    <div class="page-header">
      <h1 class="page-title"><i class="fas fa-plus"></i> Add New Case</h1>
      <p class="page-subtitle">Register a new judicial case in the system</p>
    </div>

    <div class="form-card">
      <div class="form-title">New Case Registration</div>
      <div class="form-subtitle">All fields are required. Case ID will be auto-generated.</div>

      <div class="form-group">
        <label class="form-label">Case Title</label>
        <input class="form-input" id="f-title" placeholder="e.g. Jewelry Theft at MG Road" />
      </div>

      <div class="form-group">
        <label class="form-label">Description</label>
        <textarea class="form-textarea" id="f-desc" placeholder="Brief description of the case…"></textarea>
      </div>

      <div class="form-row">
        <div class="form-group">
          <label class="form-label">Crime Type</label>
          <select class="form-select" id="f-crime">
            <option>Theft</option>
            <option>Fraud</option>
            <option>Cybercrime</option>
            <option>Robbery</option>
            <option>Assault</option>
            <option>Murder</option>
          </select>
        </div>
        <div class="form-group">
          <label class="form-label">Initial Status</label>
          <select class="form-select" id="f-status">
            <option>Open</option>
            <option>Under Investigation</option>
            <option>Closed</option>
          </select>
        </div>
      </div>

      <div class="form-group">
        <label class="form-label">Date Filed (DD-MM-YYYY)</label>
        <input class="form-input" id="f-date" value="${dateVal}" placeholder="DD-MM-YYYY" />
      </div>

      <div class="form-actions">
        <button class="btn btn-primary" id="submit-case-btn" onclick="submitNewCase()">
          ✅ Register Case
        </button>
        <button class="btn btn-secondary" onclick="navigate('cases')">Cancel</button>
      </div>
    </div>
  `);
}

async function submitNewCase() {
  const title  = document.getElementById('f-title')?.value.trim();
  const desc   = document.getElementById('f-desc')?.value.trim();
  const crime  = document.getElementById('f-crime')?.value;
  const status = document.getElementById('f-status')?.value;
  const date   = document.getElementById('f-date')?.value.trim();

  if (!title || !desc || !date) {
    showToast('⚠️ Please fill all fields.', 'error');
    return;
  }

  const btn = document.getElementById('submit-case-btn');
  btn.textContent = 'Registering…';
  btn.disabled = true;

  try {
    const r = await fetch(`${API}/cases`, {
      method: 'POST',
      headers: { 
        'Content-Type': 'application/json',
        'x-user-id': sessionStorage.getItem('userId') || '',
        'x-user-role': sessionStorage.getItem('userRole') || ''
      },
      body: JSON.stringify({ Title: title, Description: desc, Start_Date: date, Status: status, Crime_Type: crime })
    });
    const data = await r.json();
    if (r.ok) {
      showToast(`✅ Case ${data.case.Case_Id} registered!`, 'success');
      setTimeout(() => navigate('detail', data.case.Case_Id), 800);
    } else {
      showToast('❌ ' + (data.error || 'Failed'), 'error');
      btn.textContent = '✅ Register Case';
      btn.disabled = false;
    }
  } catch {
    showToast('❌ Server error', 'error');
    btn.textContent = '✅ Register Case';
    btn.disabled = false;
  }
}
