# RevPlay - Quick Start Guide

Get RevPlay up and running in 5 minutes!

## Prerequisites Check

Before starting, ensure you have:
- ✅ Java 17 or higher (`java -version`)
- ✅ Node.js 18+ and npm (`node -v` and `npm -v`)
- ✅ PostgreSQL 14+ (`psql --version`)
- ✅ Maven 3.8+ (`mvn -v`)

## Step 1: Database Setup (2 minutes)

```bash
# Create database
psql -U postgres -c "CREATE DATABASE revplay;"

# Run schema
psql -U postgres -d revplay -f database/schema.sql

# Verify
psql -U postgres -d revplay -c "\dt"
```

## Step 2: Backend Setup (1 minute)

```bash
# Navigate to backend
cd backend

# Update database credentials (if needed)
# Edit: src/main/resources/application.properties
# Change: spring.datasource.username and spring.datasource.password

# Build and run
mvn spring-boot:run
```

**Backend will start on:** http://localhost:8081

**Swagger UI available at:** http://localhost:8081/swagger-ui.html

## Step 3: Frontend Setup (2 minutes)

Open a new terminal:

```bash
# Navigate to frontend
cd frontend

# Install dependencies
npm install

# Start development server
npm start
```

**Frontend will start on:** http://localhost:4200

## Step 4: Verify Installation

### Check Backend
Open browser: http://localhost:8081/swagger-ui.html

You should see the Swagger API documentation.

### Check Frontend
Open browser: http://localhost:4200

You should see the RevPlay landing page.

### Test API
```bash
# Health check
curl http://localhost:8081/api/health

# Should return: {"status":"ok","message":"RevPlay API is running"}
```

## Step 5: Create Your First Account

1. Go to http://localhost:4200
2. Click "Sign Up" or "Get Started Free"
3. Fill in the registration form:
   - Email: your@email.com
   - Username: yourname
   - Password: yourpassword
   - Role: User or Artist
4. Click "Register"
5. You'll be automatically logged in!

## Step 6: Upload Your First Song (Artists Only)

If you registered as an Artist:

### Using Swagger UI:
1. Go to http://localhost:8081/swagger-ui.html
2. Click "Authorize" button (top right)
3. Enter your JWT token (from login response)
4. Find "File Upload" section
5. Use POST `/api/upload/audio` to upload an MP3 file
6. Copy the returned file path
7. Use POST `/api/songs` to create a song entry with the file path

### Using cURL:
```bash
# Login first to get token
curl -X POST http://localhost:8081/api/auth/login \
  -H "Content-Type: application/json" \
  -d '{"emailOrUsername":"yourname","password":"yourpassword"}'

# Upload MP3 (replace YOUR_TOKEN and path/to/song.mp3)
curl -X POST http://localhost:8081/api/upload/audio \
  -H "Authorization: Bearer YOUR_TOKEN" \
  -F "file=@path/to/song.mp3"
```

## Common Issues & Solutions

### Issue: Database connection failed
**Solution:**
```bash
# Check PostgreSQL is running
sudo systemctl status postgresql

# Start PostgreSQL
sudo systemctl start postgresql

# Verify credentials in application.properties
```

### Issue: Port 8081 already in use
**Solution:**
```bash
# Find process using port 8081
lsof -i :8081

# Kill the process
kill -9 <PID>

# Or change port in application.properties
server.port=8082
```

### Issue: Port 4200 already in use
**Solution:**
```bash
# Kill process on port 4200
npx kill-port 4200

# Or use different port
ng serve --port 4201
```

### Issue: CORS errors
**Solution:**
- Verify backend is running on port 8081
- Check SecurityConfig.java has correct CORS configuration
- Clear browser cache

### Issue: Maven build fails
**Solution:**
```bash
# Clean and rebuild
cd backend
mvn clean install -U

# Skip tests if needed
mvn clean install -DskipTests
```

### Issue: npm install fails
**Solution:**
```bash
# Clear cache and reinstall
cd frontend
rm -rf node_modules package-lock.json
npm cache clean --force
npm install
```

## Next Steps

### Explore the Application
- Browse songs at http://localhost:4200/songs
- View artists at http://localhost:4200/artists
- Check albums at http://localhost:4200/albums
- Create playlists (requires login)

### API Documentation
- Swagger UI: http://localhost:8081/swagger-ui.html
- API Docs JSON: http://localhost:8081/api-docs

### Development
- Backend code: `backend/src/main/java/com/revplay/`
- Frontend code: `frontend/src/app/`
- Database schema: `database/schema.sql`

### Testing
```bash
# Backend tests
cd backend
mvn test

# Frontend tests
cd frontend
npm test
```

## Useful Commands

### Backend
```bash
# Run with dev profile
mvn spring-boot:run -Dspring-boot.run.profiles=dev

# Build JAR
mvn clean package

# Run JAR
java -jar target/revplay-backend-1.0.0.jar

# Run tests with coverage
mvn test jacoco:report
```

### Frontend
```bash
# Development server
npm start

# Build for production
npm run build

# Run tests
npm test

# Run tests with coverage
npm test -- --code-coverage
```

### Database
```bash
# Connect to database
psql -U postgres -d revplay

# List tables
\dt

# Describe table
\d users

# Backup database
pg_dump -U postgres revplay > backup.sql

# Restore database
psql -U postgres revplay < backup.sql
```

## Project Structure

```
revplay/
├── backend/                    # Spring Boot API
│   ├── src/main/java/com/revplay/
│   │   ├── RevPlayApplication.java    ← Main application file
│   │   ├── controller/                ← REST endpoints
│   │   ├── model/                     ← JPA entities
│   │   ├── repository/                ← Data access
│   │   ├── service/                   ← Business logic
│   │   ├── security/                  ← JWT & auth
│   │   └── config/                    ← Configuration
│   └── pom.xml                        ← Maven dependencies
├── frontend/                   # Angular app
│   ├── src/app/
│   │   ├── components/                ← UI components
│   │   ├── services/                  ← Business logic
│   │   └── guards/                    ← Route protection
│   └── package.json                   ← npm dependencies
└── database/
    └── schema.sql                     ← Database schema
```

## Support & Documentation

- Main README: [README.md](README.md)
- Backend Guide: [backend/README.md](backend/README.md)
- Frontend Guide: [frontend/README.md](frontend/README.md)
- Database Guide: [database/README.md](database/README.md)
- API Documentation: [docs/API_DOCUMENTATION.md](docs/API_DOCUMENTATION.md)
- Architecture: [docs/ARCHITECTURE.md](docs/ARCHITECTURE.md)
- Testing Guide: [docs/TESTING.md](docs/TESTING.md)

## Getting Help

If you encounter issues:
1. Check this quick start guide
2. Review the troubleshooting section
3. Check the detailed README files
4. Review Swagger API documentation
5. Check application logs

## Success! 🎉

You now have RevPlay running locally. Start exploring, uploading music, and building your playlists!

Happy streaming! 🎵
