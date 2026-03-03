# RevPlay - Windows Quick Start

## 🚀 Easy Start (3 Options)

### Option 1: Interactive Menu (Recommended)
Double-click: **`QUICK_START.bat`**

This will show you a menu with all options:
1. Setup Database (first time only)
2. Start Application
3. Start Backend Only
4. Start Frontend Only
5. And more...

### Option 2: Automatic Start
Double-click: **`RUN_REVPLAY.bat`**

This will automatically:
- Check MySQL
- Check database
- Start backend
- Start frontend
- Open browser

### Option 3: PowerShell Script
Right-click **`START_REVPLAY.ps1`** → Run with PowerShell

## 📋 First Time Setup

### Step 1: Setup Database

Double-click: **`SETUP_DATABASE.bat`**

This will:
1. Create 'revplay' database
2. Create all tables
3. You'll need to enter MySQL root password twice

### Step 2: Configure Password

Edit: `backend/src/main/resources/application.properties`

Change this line:
```properties
spring.datasource.password=your_password
```

To your actual MySQL root password:
```properties
spring.datasource.password=YourActualPassword
```

### Step 3: Start Application

Double-click: **`RUN_REVPLAY.bat`**

## 🎯 What You'll See

### Two Command Windows Will Open:

**Window 1: Backend**
```
🎵  RevPlay API Started  🎵
Server running on: http://localhost:8081
```

**Window 2: Frontend**
```
Serving HTTP on 0.0.0.0 port 8000
```

### Browser Will Open Automatically
- URL: http://localhost:8000
- You'll see the RevPlay landing page

## 🎵 Using RevPlay

### 1. Register
- Click "Sign Up" or "Get Started Free"
- Fill in your details
- Choose role: User or Artist

### 2. Login
- Click "Login"
- Enter credentials
- You're in!

### 3. Browse Music
- Click "Songs" to see all songs
- Click "Artists" to see all artists
- Click "Albums" to see all albums

### 4. Play Music
- Click on any song card
- Player appears at bottom
- Use controls to play/pause, seek, adjust volume

### 5. Upload Music (Artists Only)
- Go to: http://localhost:8081/swagger-ui.html
- Click "Authorize" and enter your token
- Use "File Upload" endpoints to upload MP3 files
- Create songs with the uploaded files

## 🛠️ Troubleshooting

### MySQL Not Running
```
Services → MySQL80 → Start
```

Or in Command Prompt (as Administrator):
```cmd
net start MySQL80
```

### Port Already in Use

**Backend (8081):**
```cmd
netstat -ano | findstr :8081
taskkill /PID <PID> /F
```

**Frontend (8000):**
```cmd
netstat -ano | findstr :8000
taskkill /PID <PID> /F
```

### Database Not Found
Run: **`SETUP_DATABASE.bat`** again

### Backend Won't Start
1. Check Java is installed: `java -version`
2. Check Maven is installed: `mvn -version`
3. Check MySQL password in `application.properties`

### Frontend Won't Start
1. Check Python is installed: `python --version`
2. Or use Node.js: `npm install -g http-server`
3. Then: `http-server web-version -p 8000`

## 📍 Important URLs

| Service | URL |
|---------|-----|
| Frontend (Web) | http://localhost:8000 |
| Frontend (Angular) | http://localhost:4200 |
| Backend API | http://localhost:8081 |
| Swagger UI | http://localhost:8081/swagger-ui.html |
| API Docs | http://localhost:8081/api-docs |
| Health Check | http://localhost:8081/api/health |

## 🔧 Manual Start (If Scripts Don't Work)

### Terminal 1: Backend
```cmd
cd backend
mvn spring-boot:run
```

### Terminal 2: Frontend
```cmd
cd web-version
python -m http.server 8000
```

### Terminal 3: Angular (Optional)
```cmd
cd frontend
npm install
npm start
```

## 📁 Project Structure

```
RevPlay Project/
├── QUICK_START.bat          ← Start here!
├── RUN_REVPLAY.bat          ← Or here!
├── SETUP_DATABASE.bat       ← First time setup
├── START_REVPLAY.ps1        ← PowerShell version
├── backend/                 ← Spring Boot API
├── web-version/             ← HTML/CSS/JS version
├── frontend/                ← Angular version
└── database/                ← MySQL schema
```

## ✅ Success Checklist

- [ ] MySQL is running
- [ ] Database created
- [ ] Password configured
- [ ] Backend started (port 8081)
- [ ] Frontend started (port 8000)
- [ ] Browser opened automatically
- [ ] Can see RevPlay landing page
- [ ] Can register a user
- [ ] Can login
- [ ] Can browse songs
- [ ] Can play music

## 🎉 You're All Set!

Enjoy using RevPlay! 🎵

For more help, see:
- `START_APPLICATION.md` - Detailed guide
- `README.md` - Full documentation
- `web-version/README.md` - Web version details
