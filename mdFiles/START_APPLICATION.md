# Start RevPlay Application

## Quick Start Guide

Follow these steps to run the RevPlay application:

## Step 1: Setup MySQL Database

### Create Database
```bash
# Open MySQL command line
mysql -u root -p

# Create database
CREATE DATABASE revplay CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

# Exit MySQL
exit
```

### Run Schema
```bash
# Navigate to project root
cd "C:\Users\gaytr\OneDrive\Desktop\RevPlay Project"

# Run schema
mysql -u root -p revplay < database/schema.sql
```

### Verify Database
```bash
mysql -u root -p revplay -e "SHOW TABLES;"
```

You should see 9 tables created.

## Step 2: Configure Backend

### Update Database Password

Edit `backend/src/main/resources/application.properties`:

```properties
spring.datasource.password=YOUR_MYSQL_ROOT_PASSWORD
```

Or edit `backend/src/main/resources/application-dev.properties` if using dev profile.

## Step 3: Start Backend

### Option A: Using Maven
```bash
cd backend
mvn clean install
mvn spring-boot:run
```

### Option B: Using Maven Wrapper (Windows)
```bash
cd backend
mvnw.cmd clean install
mvnw.cmd spring-boot:run
```

### Verify Backend
- Backend should start on: http://localhost:8081
- Swagger UI: http://localhost:8081/swagger-ui.html
- Check console for: "🎵 RevPlay API Started 🎵"

## Step 4: Choose Frontend Option

### Option A: Pure HTML/CSS/JS Version (Recommended for Quick Start)

```bash
# Open new terminal
cd web-version

# Start simple HTTP server
python -m http.server 8000
```

**Access at:** http://localhost:8000

### Option B: Angular Version (Full Featured)

```bash
# Open new terminal
cd frontend

# Install dependencies (first time only)
npm install

# Start development server
npm start
```

**Access at:** http://localhost:4200

## Step 5: Test the Application

### 1. Register a User
- Click "Sign Up" or "Get Started Free"
- Fill in:
  - Email: test@example.com
  - Username: testuser
  - Password: password123
  - Role: User or Artist
- Click Register

### 2. Login
- Click "Login"
- Enter username and password
- Click Login

### 3. Upload a Song (Artists Only)

If you registered as Artist, use Swagger UI:

1. Go to http://localhost:8081/swagger-ui.html
2. Click "Authorize" button
3. Enter: `Bearer YOUR_JWT_TOKEN` (get token from login response)
4. Find "File Upload" section
5. POST `/api/upload/audio` - Upload an MP3 file
6. Copy the returned file path
7. POST `/api/songs` - Create song with:
```json
{
  "title": "My First Song",
  "genre": "Pop",
  "duration": 180,
  "audioFile": "/songs/uuid-filename.mp3",
  "coverImage": "/covers/default.jpg"
}
```

### 4. Play Music
- Go to "Songs" section
- Click on any song card
- Music player appears at bottom
- Use controls to play/pause, seek, adjust volume

## Troubleshooting

### Backend Won't Start

**Issue: Port 8081 already in use**
```bash
# Windows
netstat -ano | findstr :8081
taskkill /PID <PID> /F

# Or change port in application.properties
server.port=8082
```

**Issue: Database connection failed**
- Check MySQL is running: `mysql -u root -p`
- Verify database exists: `SHOW DATABASES;`
- Check password in application.properties

**Issue: Maven not found**
```bash
# Install Maven or use wrapper
cd backend
mvnw.cmd spring-boot:run
```

### Frontend Won't Start

**Issue: Python not found**
```bash
# Use Node.js http-server instead
npm install -g http-server
cd web-version
http-server -p 8000
```

**Issue: npm not found (Angular version)**
- Install Node.js from https://nodejs.org/
- Restart terminal
- Run `npm install`

### Database Issues

**Issue: Access denied for user 'root'**
```bash
# Reset MySQL root password
mysql -u root
ALTER USER 'root'@'localhost' IDENTIFIED BY 'newpassword';
FLUSH PRIVILEGES;
```

**Issue: Unknown database 'revplay'**
```bash
mysql -u root -p
CREATE DATABASE revplay CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
```

**Issue: Table doesn't exist**
```bash
# Re-run schema
mysql -u root -p revplay < database/schema.sql
```

### Audio Not Playing

**Issue: 404 on audio file**
- Check uploads folder exists: `backend/uploads/songs/`
- Verify audio file path in database
- Check file permissions

**Issue: CORS error**
- Verify backend CORS configuration allows frontend origin
- Check SecurityConfig.java

## Verification Checklist

- [ ] MySQL is running
- [ ] Database 'revplay' exists
- [ ] All 9 tables created
- [ ] Backend starts without errors
- [ ] Backend accessible at http://localhost:8081
- [ ] Swagger UI loads at http://localhost:8081/swagger-ui.html
- [ ] Frontend starts without errors
- [ ] Frontend accessible (port 8000 or 4200)
- [ ] Can register a user
- [ ] Can login
- [ ] Can see songs list
- [ ] Can play music

## Default Test Data

You can insert test data manually:

```sql
USE revplay;

-- Insert test user
INSERT INTO users (email, username, password, role) 
VALUES ('test@example.com', 'testuser', '$2a$10$N9qo8uLOickgx2ZMRZoMyeIjZAgcfl7p92ldGxad68LJZdL17lhWy', 'user');

-- Insert test artist
INSERT INTO users (email, username, password, role) 
VALUES ('artist@example.com', 'testartist', '$2a$10$N9qo8uLOickgx2ZMRZoMyeIjZAgcfl7p92ldGxad68LJZdL17lhWy', 'artist');

INSERT INTO artists (user_id, artist_name, bio, genre)
VALUES (2, 'Test Artist', 'A test artist', 'Pop');

-- Insert test song (you need to upload audio file first)
INSERT INTO songs (title, genre, duration, audio_file, artist_id, visibility)
VALUES ('Test Song', 'Pop', 180, '/songs/test.mp3', 1, 'public');
```

Note: Password is 'password' (BCrypt hashed)

## Next Steps

1. Upload some MP3 files
2. Create playlists
3. Add songs to favorites
4. Explore all features
5. Check Swagger documentation for all API endpoints

## Support

If you encounter issues:
1. Check console logs (backend and frontend)
2. Check browser developer console (F12)
3. Review error messages
4. Check this troubleshooting guide
5. Review documentation in docs/ folder

## Useful Commands

```bash
# Check if MySQL is running
mysql -u root -p -e "SELECT 'MySQL is running!' as status;"

# Check backend health
curl http://localhost:8081/api/health

# Check if port is in use
netstat -ano | findstr :8081
netstat -ano | findstr :8000
netstat -ano | findstr :4200

# View backend logs
cd backend
mvn spring-boot:run

# View MySQL logs
mysql -u root -p -e "SHOW VARIABLES LIKE 'log_error';"
```

## Quick Commands Summary

```bash
# Terminal 1: MySQL (if not running as service)
mysql.server start  # macOS
sudo systemctl start mysql  # Linux
# Windows: Start MySQL service from Services

# Terminal 2: Backend
cd backend
mvn spring-boot:run

# Terminal 3: Frontend (Web Version)
cd web-version
python -m http.server 8000

# OR Frontend (Angular Version)
cd frontend
npm start
```

## Success!

If everything is working:
- ✅ Backend running on http://localhost:8081
- ✅ Frontend running on http://localhost:8000 or http://localhost:4200
- ✅ Can register and login
- ✅ Can browse songs
- ✅ Can play music

Enjoy RevPlay! 🎵
