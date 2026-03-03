# 🎵 START HERE - RevPlay Quick Guide

## 👋 Welcome to RevPlay!

This is your complete music streaming application. Follow these simple steps to get started.

## 🚀 Quick Start (3 Steps)

### Step 1: Setup Database (First Time Only)

**Double-click:** `SETUP_DATABASE.bat`

- Enter your MySQL root password when asked
- Wait for "Database Setup Complete!" message
- You should see 9 tables created

### Step 2: Configure Password

**Edit:** `backend/src/main/resources/application.properties`

Find this line:
```properties
spring.datasource.password=your_password
```

Change it to your actual MySQL password:
```properties
spring.datasource.password=root
```
(or whatever your MySQL root password is)

**Save the file!**

### Step 3: Start Application

**Double-click:** `RUN_REVPLAY.bat`

- Two windows will open (Backend & Frontend)
- Browser opens automatically to http://localhost:8000
- Wait about 30 seconds for everything to start

## ✅ That's It!

You should now see the RevPlay landing page in your browser.

## 🎯 What to Do Next

### 1. Create an Account
- Click "Sign Up" or "Get Started Free"
- Fill in your details
- Choose "User" or "Artist"
- Click Register

### 2. Login
- Click "Login"
- Enter your credentials
- Click Login

### 3. Explore
- Click "Songs" to browse music
- Click "Artists" to see artists
- Click "Albums" to view albums

### 4. Play Music
- Click on any song
- Player appears at bottom
- Use controls to play/pause, seek, adjust volume

## 📁 Important Files

| File | Purpose |
|------|---------|
| `QUICK_START.bat` | Interactive menu with all options |
| `RUN_REVPLAY.bat` | Start everything automatically |
| `SETUP_DATABASE.bat` | Create database (first time) |
| `HOW_TO_RUN.txt` | Detailed instructions |
| `README_WINDOWS.md` | Windows-specific guide |

## 🌐 URLs You'll Need

| Service | URL |
|---------|-----|
| **Main App** | http://localhost:8000 |
| **API** | http://localhost:8081 |
| **Swagger** | http://localhost:8081/swagger-ui.html |

## ❓ Having Issues?

### MySQL Not Running?
```
Services → MySQL80 → Start
```

### Database Not Found?
Run `SETUP_DATABASE.bat` again

### Backend Won't Start?
Check the password in `application.properties`

### Port Already in Use?
```cmd
netstat -ano | findstr :8081
taskkill /PID <number> /F
```

## 📖 More Help

- **Quick Reference:** `HOW_TO_RUN.txt`
- **Windows Guide:** `README_WINDOWS.md`
- **Full Docs:** `README.md`
- **Startup Guide:** `START_APPLICATION.md`

## 🎵 Features

- ✅ Browse songs, artists, and albums
- ✅ Play music with full controls
- ✅ Create playlists
- ✅ Add favorites
- ✅ Search functionality
- ✅ User authentication
- ✅ Artist uploads (via Swagger)
- ✅ Responsive design

## 💡 Pro Tips

1. **Use Swagger for uploads:** http://localhost:8081/swagger-ui.html
2. **Keep both windows open** while using the app
3. **Check console** if something doesn't work
4. **Use search** to find songs quickly

## 🎉 You're Ready!

Just follow the 3 steps above and you'll be streaming music in minutes!

---

**Need help?** Check `HOW_TO_RUN.txt` for detailed instructions.

**Enjoy RevPlay!** 🎵
