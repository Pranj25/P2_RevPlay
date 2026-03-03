# How to Start RevPlay - Complete Guide

## Quick Start (Easiest Way)

### First Time Setup:
1. Double-click `SETUP_DATABASE.bat`
2. Enter MySQL password when prompted: `PranjalP@2003`
3. Wait for database creation

### Start Application:
1. Double-click `START_BOTH_SERVERS.bat`
2. Wait for both servers to start (about 35 seconds)
3. Browser will open automatically at http://localhost:4200

**That's it!** 🎉

---

## Manual Start (Step by Step)

### Prerequisites:
- ✅ MySQL installed and running
- ✅ Java 17+ installed
- ✅ Node.js and npm installed
- ✅ Maven installed

### Step 1: Start MySQL
```bash
# Check if MySQL is running
sc query MySQL80

# If not running, start it:
net start MySQL80
```

### Step 2: Setup Database (First Time Only)
```bash
# Option A: Use batch file
SETUP_DATABASE.bat

# Option B: Manual setup
mysql -u root -pPranjalP@2003
CREATE DATABASE revplayProject CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE revplayProject;
source database/schema.sql;
exit
```

### Step 3: Start Backend Server
Open **Terminal 1** (Command Prompt or PowerShell):
```bash
cd backend
mvn spring-boot:run
```

Wait until you see:
```
Started RevPlayApplication in X.XXX seconds
```

Backend will be running on: **http://localhost:8081**

### Step 4: Start Frontend Server
Open **Terminal 2** (Command Prompt or PowerShell):
```bash
cd frontend
npm install    # First time only
npm start
```

Wait until you see:
```
✔ Compiled successfully
```

Frontend will be running on: **http://localhost:4200**

### Step 5: Access Application
Open browser and go to: **http://localhost:4200**

---

## Using Different Methods

### Method 1: Automated Script (Recommended)
```bash
START_BOTH_SERVERS.bat
```
- Starts both servers automatically
- Opens browser
- Easiest method

### Method 2: Quick Start Menu
```bash
QUICK_START.bat
```
- Interactive menu
- Choose what to start
- More control

### Method 3: Individual Scripts

**Backend Only:**
```bash
cd backend
mvn spring-boot:run
```

**Frontend Only:**
```bash
cd frontend
npm start
```

### Method 4: IDE (IntelliJ IDEA / VS Code)

**Backend (IntelliJ IDEA):**
1. Open `backend` folder in IntelliJ
2. Find `RevPlayApplication.java`
3. Right-click → Run 'RevPlayApplication'

**Frontend (VS Code):**
1. Open `frontend` folder in VS Code
2. Open terminal (Ctrl + `)
3. Run: `npm start`

---

## Verification

### Check if Servers are Running:

**Backend:**
- Open: http://localhost:8081
- Should see: RevPlay API landing page
- Or check: http://localhost:8081/swagger-ui.html

**Frontend:**
- Open: http://localhost:4200
- Should see: RevPlay home page

**Database:**
```bash
mysql -u root -pPranjalP@2003 -e "USE revplayProject; SHOW TABLES;"
```
Should show 9 tables.

---

## Troubleshooting

### Problem: "Port 8081 already in use"
**Solution:**
```bash
# Find process using port 8081
netstat -ano | findstr :8081

# Kill the process (replace PID with actual number)
taskkill /PID <PID> /F
```

### Problem: "Port 4200 already in use"
**Solution:**
```bash
# Find process using port 4200
netstat -ano | findstr :4200

# Kill the process
taskkill /PID <PID> /F
```

### Problem: "MySQL is not running"
**Solution:**
```bash
# Start MySQL service
net start MySQL80

# Or use Services app
services.msc
# Find MySQL80 → Right-click → Start
```

### Problem: "Database 'revplayProject' doesn't exist"
**Solution:**
```bash
# Run setup script
SETUP_DATABASE.bat

# Or create manually
mysql -u root -pPranjalP@2003 -e "CREATE DATABASE revplayProject;"
mysql -u root -pPranjalP@2003 revplayProject < database/schema.sql
```

### Problem: "npm: command not found"
**Solution:**
- Install Node.js from: https://nodejs.org/
- Restart terminal after installation

### Problem: "mvn: command not found"
**Solution:**
- Install Maven from: https://maven.apache.org/
- Add to PATH environment variable
- Restart terminal

### Problem: Backend starts but shows errors
**Solution:**
1. Check `application.properties` has correct password
2. Verify database exists: `mysql -u root -pPranjalP@2003 -e "SHOW DATABASES;"`
3. Check MySQL is running: `sc query MySQL80`

### Problem: Frontend shows "Cannot GET /"
**Solution:**
1. Make sure you're on http://localhost:4200 (not 8081)
2. Wait for Angular to compile (check terminal)
3. Try: `cd frontend && npm install && npm start`

---

## Stopping the Servers

### Method 1: Close Terminal Windows
- Simply close both command prompt windows
- Servers will stop automatically

### Method 2: Ctrl+C
- In each terminal window, press `Ctrl+C`
- Confirm with `Y` if prompted

### Method 3: Task Manager
1. Open Task Manager (Ctrl+Shift+Esc)
2. Find `java.exe` (backend) and `node.exe` (frontend)
3. Right-click → End Task

---

## Development Workflow

### Daily Development:
1. Start MySQL (if not running)
2. Run `START_BOTH_SERVERS.bat`
3. Code in your IDE
4. Changes auto-reload:
   - Backend: Save Java file → Maven recompiles
   - Frontend: Save TypeScript/HTML → Angular recompiles
5. Close terminals when done

### Backend Changes:
- Java files: Auto-reload with Spring DevTools
- Properties files: Restart backend server
- Database schema: Run migration or restart

### Frontend Changes:
- TypeScript/HTML/SCSS: Auto-reload (hot reload)
- package.json: Run `npm install` and restart
- angular.json: Restart frontend server

---

## Production Deployment

### Build Backend:
```bash
cd backend
mvn clean package
java -jar target/revplay-0.0.1-SNAPSHOT.jar --spring.profiles.active=prod
```

### Build Frontend:
```bash
cd frontend
npm run build
# Deploy dist/ folder to web server
```

---

## Useful Commands

### Check Running Servers:
```bash
# Check ports
netstat -ano | findstr :8081
netstat -ano | findstr :4200

# Check MySQL
sc query MySQL80
```

### View Logs:
```bash
# Backend logs (in terminal)
cd backend
mvn spring-boot:run

# Frontend logs (in terminal)
cd frontend
npm start
```

### Database Commands:
```bash
# Connect to database
mysql -u root -pPranjalP@2003 revplayProject

# Show tables
SHOW TABLES;

# View data
SELECT * FROM users;
SELECT * FROM songs;
```

---

## URLs Reference

| Service | URL | Purpose |
|---------|-----|---------|
| Frontend | http://localhost:4200 | Main application |
| Backend API | http://localhost:8081 | REST API |
| Swagger UI | http://localhost:8081/swagger-ui.html | API documentation |
| API Docs JSON | http://localhost:8081/api-docs | OpenAPI spec |
| API Landing | http://localhost:8081/ | API info page |

---

## Summary

**Easiest Way:**
1. `SETUP_DATABASE.bat` (first time only)
2. `START_BOTH_SERVERS.bat`
3. Wait 35 seconds
4. Browser opens automatically

**Manual Way:**
1. Start MySQL
2. Terminal 1: `cd backend && mvn spring-boot:run`
3. Terminal 2: `cd frontend && npm start`
4. Open http://localhost:4200

**Keep both terminals open while using the application!**
