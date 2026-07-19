# CaseTrack - Installation and Setup Guidelines

This document provides step-by-step instructions to set up, install, and run the CaseTrack Full-Stack Application on your local machine.

## Prerequisites

Before you begin, ensure you have the following installed on your system:
1. **Node.js** (v14 or higher) - [Download Node.js](https://nodejs.org/)
2. **Microsoft SQL Server** (Developer or Express edition) with an instance named `SQLEXPRESS` - [Download SQL Server Express](https://www.microsoft.com/en-us/sql-server/sql-server-downloads)
3. **SQL Server Management Studio (SSMS)** or Azure Data Studio - [Download SSMS](https://docs.microsoft.com/en-us/sql/ssms/download-sql-server-management-studio-ssms)

---

## Step 1: Extract the Project

If the project is in a `.zip` file, extract the entire `CaseTrack` folder to your desired location (e.g., Desktop).

---

## Step 2: Database Setup (Microsoft SQL Server)

1. Open **SQL Server Management Studio (SSMS)** and connect to your local server (e.g., `localhost\SQLEXPRESS`).
2. Open the file named `Project.sql` (located in the main `CaseTrack` project folder) in SSMS.
3. Click the **Execute** button (or press `F5`) to run the script. This will automatically:
   - Create the `CaseTrack` database.
   - Create all necessary tables (`CaseFile`, `CrimeScene`, `Officer`, `CaseSuspect`, `Evidence`, `Clue`, `Verdict`, etc.).
4. **Importing Data (Optional but Recommended):**
   - Since the database tables are initially empty, you can import the sample data from the provided `.csv` files.
   - In SSMS Object Explorer, right-click the `CaseTrack` database -> **Tasks** -> **Import Flat File...**
   - Follow the wizard to import each CSV file into its respective table (e.g., `CaseFile.csv` into `dbo.CaseFile`).

---

## Step 3: Install Node.js Dependencies

1. Open a terminal or command prompt.
2. Navigate to the project folder where `package.json` is located:
   ```bash
   cd "path/to/CaseTrack"
   ```
   *(If you are using Visual Studio Code, you can simply open the folder in VS Code and open an Integrated Terminal: `Terminal` -> `New Terminal`)*
3. Run the following command to install all required libraries (Express, mssql, cors, etc.):
   ```bash
   npm install
   ```

---

## Step 4: Verify Database Connection Configuration

1. Open `server.js` in a text editor (like VS Code).
2. Locate the `dbConfig` object (around line 13).
3. Ensure the `server` property matches your MS SQL Server instance name. By default, it is configured for `SQLEXPRESS`:
   ```javascript
   const dbConfig = {
     server: 'localhost\\SQLEXPRESS', // Update this if your instance name is different
     database: 'CaseTrack',
     driver: 'msnodesqlv8', 
     options: {
       trustedConnection: true,
       encrypt: false
     }
   };
   ```

---

## Step 5: Start the Server

1. In the terminal (inside the project folder), run the following command:
   ```bash
   npm start
   ```
   *(Alternatively, you can run `node server.js`)*
2. If the setup is correct, you will see output similar to:
   ```
   ✅ Connected to MS SQL Server (CaseTrack database)

   CaseTrack Server running at http://localhost:3000
   ```

---

## Step 6: Access the Application

1. Open your web browser (Chrome, Edge, Firefox, etc.).
2. Go to the following URL:
   [http://localhost:3000](http://localhost:3000)
3. You should now see the CaseTrack Dashboard loaded and fully functional!

## Troubleshooting
- **Database Connection Failed:** Make sure your SQL server is running. You can check this by opening "Services" in Windows and ensuring `SQL Server (SQLEXPRESS)` is listed as "Running".
- **Port in Use:** If port 3000 is occupied, you can change the `PORT` variable in `server.js` from `3000` to `3001` or another available port.
- **Login Failures in logs:** If you see login failures, ensure that Windows Authentication is enabled for SQL Server, as `msnodesqlv8` uses `trustedConnection: true` by default.
