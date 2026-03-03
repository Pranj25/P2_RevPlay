# RevPlay - Music Streaming Application

A full-stack monolithic music streaming web application built with Spring Boot and Angular.

## Features

- User authentication and authorization (User/Artist roles)
- Music library browsing (songs, albums, artists)
- MP3 file upload and playback with real audio streaming
- Music player with playback controls (play, pause, seek, volume)
- Playlist management
- Favorites system
- Artist profiles and music uploads
- Search and filtering capabilities
- Swagger API documentation
- Custom error pages (404)
- Request/Response logging interceptor
- Global exception handling
- Unit tests for controllers and services

## Tech Stack

### Backend
- Java 17
- Spring Boot 3.2.0
- Spring Security with JWT
- Spring Data JPA
- PostgreSQL
- Maven

### Frontend
- Angular 17
- TypeScript
- RxJS
- Standalone Components

## Quick Start

**New to RevPlay?** Check out our [Quick Start Guide](QUICKSTART.md) for a 5-minute setup!

## Prerequisites

- Java 17 or higher
- Node.js 18+ and npm
- PostgreSQL 14+
- Maven 3.8+

## Database Setup

### MySQL Setup (New!)

1. Install MySQL 8.0+
2. Create database:
```sql
CREATE DATABASE revplay CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
```

3. Run the schema:
```bash
mysql -u root -p revplay < database/schema.sql
```

For detailed MySQL setup instructions, see [database/MYSQL_SETUP.md](database/MYSQL_SETUP.md)

### PostgreSQL Setup (Alternative)

1. Create PostgreSQL database:
```sql
CREATE DATABASE revplay;
```

2. Run the schema from `database/schema.sql`

## Running the Application

### Option 1: Angular Frontend (Recommended)

**Backend:**
```bash
cd backend
mvn spring-boot:run
```

**Frontend:**
```bash
cd frontend
npm install
npm start
```

Access at: http://localhost:4200

### Option 2: Pure HTML/CSS/JS Version

**Backend:**
```bash
cd backend
mvn spring-boot:run
```

**Frontend:**
```bash
cd web-version
python -m http.server 8000
# Or use any static file server
```

Access at: http://localhost:8000

See [web-version/README.md](web-version/README.md) for details.

## Frontend Setup

1. Navigate to frontend directory:
```bash
cd frontend
```

2. Install dependencies:
```bash
npm install
```

3. Run development server:
```bash
npm start
```

Frontend will run on http://localhost:4200

## API Endpoints

### Authentication
- POST `/api/auth/register` - Register new user
- POST `/api/auth/login` - Login user

### Songs
- GET `/api/songs` - Get all public songs
- GET `/api/songs/{id}` - Get song by ID
- POST `/api/songs` - Upload song (Artist only)
- PUT `/api/songs/{id}/play` - Increment play count

### File Upload
- POST `/api/upload/audio` - Upload MP3 file
- POST `/api/upload/cover` - Upload cover image
- POST `/api/upload/profile` - Upload profile picture

### Albums
- GET `/api/albums` - Get all albums
- GET `/api/albums/{id}` - Get album by ID
- POST `/api/albums` - Create album (Artist only)

### Artists
- GET `/api/artists` - Get all artists
- GET `/api/artists/{id}` - Get artist by ID

### Playlists
- GET `/api/playlists` - Get all playlists
- POST `/api/playlists` - Create playlist (Authenticated)

### Users
- GET `/api/users/profile` - Get current user profile
- PUT `/api/users/profile` - Update user profile

## Swagger Documentation

Access API documentation at: http://localhost:8081/swagger-ui.html

## Project Structure

```
revplay/
├── backend/              # Spring Boot API
│   ├── src/
│   │   ├── main/
│   │   │   ├── java/com/revplay/
│   │   │   │   ├── RevPlayApplication.java    ← Main entry point
│   │   │   │   ├── controller/                ← REST controllers
│   │   │   │   ├── model/                     ← JPA entities
│   │   │   │   ├── repository/                ← Data repositories
│   │   │   │   ├── service/                   ← Business logic
│   │   │   │   ├── security/                  ← JWT & security
│   │   │   │   ├── config/                    ← Configuration
│   │   │   │   ├── dto/                       ← Data transfer objects
│   │   │   │   ├── exception/                 ← Error handling
│   │   │   │   └── interceptor/               ← HTTP interceptors
│   │   │   └── resources/
│   │   │       ├── application.properties
│   │   │       ├── application-dev.properties
│   │   │       └── application-prod.properties
│   │   └── test/
│   ├── pom.xml
│   ├── mvnw                                    ← Maven wrapper (Linux/Mac)
│   └── mvnw.cmd                                ← Maven wrapper (Windows)
├── frontend/             # Angular application
│   ├── src/app/
│   │   ├── components/
│   │   │   ├── home/                          ← Landing page
│   │   │   ├── navbar/                        ← Navigation bar
│   │   │   ├── player/                        ← Music player
│   │   │   ├── songs/
│   │   │   ├── albums/
│   │   │   ├── artists/
│   │   │   ├── playlists/
│   │   │   ├── profile/
│   │   │   ├── login/
│   │   │   ├── register/
│   │   │   └── error/                         ← 404 page
│   │   ├── services/
│   │   ├── guards/
│   │   └── interceptors/
│   └── package.json
└── database/
    └── schema.sql
```

## Default Credentials

After registration, you can login with your created credentials.

## Running Tests

### Backend Tests
```bash
cd backend
mvn test
```

### Frontend Tests
```bash
cd frontend
npm test
```

## Uploading Music

1. Register as an Artist
2. Use the file upload endpoint: POST `/api/upload/audio`
3. Upload MP3 file (max 10MB)
4. Create song entry with returned file path
5. Play music through the web player

## Documentation

- **Quick Start**: [QUICKSTART.md](QUICKSTART.md) - Get started in 5 minutes
- **Contributing**: [CONTRIBUTING.md](CONTRIBUTING.md) - Contribution guidelines
- **Features**: [FEATURES.md](FEATURES.md) - Complete feature list
- **API Documentation**: http://localhost:8081/swagger-ui.html
- **Architecture**: See `docs/ARCHITECTURE.md`
- **ERD**: See `docs/ERD.md`
- **Testing Guide**: See `docs/TESTING.md`
- **API Reference**: See `docs/API_DOCUMENTATION.md`
- **Backend Guide**: See `backend/README.md`
- **Frontend Guide**: See `frontend/README.md`
- **Database Guide**: See `database/README.md`

## License

MIT
