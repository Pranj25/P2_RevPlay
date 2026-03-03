# RevPlay - Visual Guide

Visual representations of the RevPlay architecture and workflows.

## System Architecture

```
┌─────────────────────────────────────────────────────────────────┐
│                         USER BROWSER                             │
│                     http://localhost:4200                        │
└────────────────────────────┬────────────────────────────────────┘
                             │
                             │ HTTP/HTTPS
                             │
┌────────────────────────────▼────────────────────────────────────┐
│                    ANGULAR FRONTEND                              │
│  ┌──────────────────────────────────────────────────────────┐  │
│  │  Components: Home, Songs, Albums, Artists, Player, etc.  │  │
│  └──────────────────────────────────────────────────────────┘  │
│  ┌──────────────────────────────────────────────────────────┐  │
│  │  Services: Auth, Song, Player, Upload                    │  │
│  └──────────────────────────────────────────────────────────┘  │
│  ┌──────────────────────────────────────────────────────────┐  │
│  │  Guards & Interceptors: Auth Guard, JWT Interceptor      │  │
│  └──────────────────────────────────────────────────────────┘  │
└────────────────────────────┬────────────────────────────────────┘
                             │
                             │ REST API (JSON)
                             │ JWT Token in Header
                             │
┌────────────────────────────▼────────────────────────────────────┐
│                   SPRING BOOT BACKEND                            │
│                   http://localhost:8081                          │
│  ┌──────────────────────────────────────────────────────────┐  │
│  │  Controllers: Auth, Song, Album, Artist, Upload, etc.    │  │
│  └──────────────────────────────────────────────────────────┘  │
│  ┌──────────────────────────────────────────────────────────┐  │
│  │  Security: JWT Filter, Security Config                   │  │
│  └──────────────────────────────────────────────────────────┘  │
│  ┌──────────────────────────────────────────────────────────┐  │
│  │  Services: FileStorage, Business Logic                   │  │
│  └──────────────────────────────────────────────────────────┘  │
│  ┌──────────────────────────────────────────────────────────┐  │
│  │  Repositories: JPA Data Access Layer                     │  │
│  └──────────────────────────────────────────────────────────┘  │
└────────────────────────────┬────────────────────────────────────┘
                             │
                             │ JDBC
                             │
┌────────────────────────────▼────────────────────────────────────┐
│                    POSTGRESQL DATABASE                           │
│                    localhost:5432/revplay                        │
│  ┌──────────────────────────────────────────────────────────┐  │
│  │  Tables: users, artists, songs, albums, playlists, etc.  │  │
│  └──────────────────────────────────────────────────────────┘  │
└──────────────────────────────────────────────────────────────────┘

┌──────────────────────────────────────────────────────────────────┐
│                      FILE SYSTEM                                 │
│                      ./uploads/                                  │
│  ┌──────────────────────────────────────────────────────────┐  │
│  │  /songs/     - MP3 audio files                           │  │
│  │  /covers/    - Album/song cover images                   │  │
│  │  /profiles/  - User profile pictures                     │  │
│  └──────────────────────────────────────────────────────────┘  │
└──────────────────────────────────────────────────────────────────┘
```

## Authentication Flow

```
┌─────────┐                                    ┌─────────┐
│ Browser │                                    │ Backend │
└────┬────┘                                    └────┬────┘
     │                                              │
     │  1. POST /api/auth/register                 │
     │     { email, username, password, role }     │
     ├────────────────────────────────────────────>│
     │                                              │
     │                                              │  2. Hash password
     │                                              │     with BCrypt
     │                                              │
     │                                              │  3. Save user to DB
     │                                              │
     │                                              │  4. Generate JWT
     │                                              │     token
     │                                              │
     │  5. { token, user }                         │
     │<────────────────────────────────────────────┤
     │                                              │
     │  6. Store token in localStorage             │
     │                                              │
     │  7. All subsequent requests include:        │
     │     Authorization: Bearer <token>           │
     ├────────────────────────────────────────────>│
     │                                              │
     │                                              │  8. Validate JWT
     │                                              │     Extract user ID
     │                                              │
     │  9. Protected resource                      │
     │<────────────────────────────────────────────┤
     │                                              │
```

## File Upload Flow

```
┌─────────┐                                    ┌─────────┐
│ Browser │                                    │ Backend │
└────┬────┘                                    └────┬────┘
     │                                              │
     │  1. Select MP3 file                         │
     │                                              │
     │  2. POST /api/upload/audio                  │
     │     Content-Type: multipart/form-data       │
     │     Authorization: Bearer <token>           │
     │     file: [binary data]                     │
     ├────────────────────────────────────────────>│
     │                                              │
     │                                              │  3. Validate JWT
     │                                              │
     │                                              │  4. Validate file:
     │                                              │     - Type: audio/mpeg
     │                                              │     - Size: < 10MB
     │                                              │
     │                                              │  5. Generate UUID
     │                                              │     filename
     │                                              │
     │                                              │  6. Save to:
     │                                              │     ./uploads/songs/
     │                                              │
     │  7. { filePath: "/songs/uuid.mp3" }         │
     │<────────────────────────────────────────────┤
     │                                              │
     │  8. POST /api/songs                         │
     │     { title, genre, duration,               │
     │       audioFile: "/songs/uuid.mp3" }        │
     ├────────────────────────────────────────────>│
     │                                              │
     │                                              │  9. Save song to DB
     │                                              │
     │  10. { song object }                        │
     │<────────────────────────────────────────────┤
     │                                              │
```

## Music Playback Flow

```
┌─────────┐                                    ┌─────────┐
│ Browser │                                    │ Backend │
└────┬────┘                                    └────┬────┘
     │                                              │
     │  1. GET /api/songs                          │
     ├────────────────────────────────────────────>│
     │                                              │
     │  2. [ { id, title, audioFile, ... } ]       │
     │<────────────────────────────────────────────┤
     │                                              │
     │  3. User clicks song                        │
     │                                              │
     │  4. PlayerService.playSong(song)            │
     │     - Set audio.src = baseUrl + audioFile   │
     │     - audio.play()                          │
     │                                              │
     │  5. GET /uploads/songs/uuid.mp3             │
     ├────────────────────────────────────────────>│
     │                                              │
     │  6. [MP3 binary stream]                     │
     │<────────────────────────────────────────────┤
     │                                              │
     │  7. HTML5 Audio plays stream                │
     │                                              │
     │  8. PUT /api/songs/{id}/play                │
     │     (increment play count)                  │
     ├────────────────────────────────────────────>│
     │                                              │
     │                                              │  9. Update play_count
     │                                              │     in database
     │                                              │
     │  10. 200 OK                                 │
     │<────────────────────────────────────────────┤
     │                                              │
```

## Database Entity Relationships

```
┌──────────────┐
│    users     │
│──────────────│
│ id (PK)      │
│ email        │◄──────────┐
│ username     │           │ 1:1
│ password     │           │
│ role         │           │
└──────────────┘           │
       │                   │
       │ 1:N               │
       │              ┌────┴──────┐
       │              │  artists  │
       │              │───────────│
       │              │ id (PK)   │
       │              │ user_id   │
       │              │ name      │
       │              │ bio       │
       │              └─────┬─────┘
       │                    │
       │                    │ 1:N
       │                    │
       │              ┌─────▼─────┐
       │              │   songs   │
       │              │───────────│
       │              │ id (PK)   │
       │              │ title     │
       │              │ audio_file│
       │              │ artist_id │
       │              └─────┬─────┘
       │                    │
       │ 1:N                │ N:M
       │                    │
┌──────▼──────┐      ┌─────▼──────────┐
│  playlists  │      │ playlist_songs │
│─────────────│      │────────────────│
│ id (PK)     │◄─────┤ playlist_id    │
│ name        │      │ song_id        │
│ user_id     │      └────────────────┘
│ is_public   │
└─────────────┘
```

## Component Hierarchy (Frontend)

```
AppComponent
│
├── NavbarComponent
│   ├── Logo
│   ├── Navigation Links
│   └── User Menu
│
├── RouterOutlet
│   │
│   ├── HomeComponent (Landing Page)
│   │   ├── Hero Section
│   │   ├── Features Grid
│   │   ├── Browse Section
│   │   └── Footer
│   │
│   ├── SongsComponent
│   │   └── Song Cards Grid
│   │
│   ├── AlbumsComponent
│   │   └── Album Cards Grid
│   │
│   ├── ArtistsComponent
│   │   └── Artist Cards Grid
│   │
│   ├── PlaylistsComponent
│   │   └── Playlist Cards Grid
│   │
│   ├── ProfileComponent
│   │   └── User Info & Stats
│   │
│   ├── LoginComponent
│   │   └── Login Form
│   │
│   ├── RegisterComponent
│   │   └── Registration Form
│   │
│   └── ErrorComponent (404)
│       └── Error Message
│
└── PlayerComponent (Fixed Bottom)
    ├── Song Info
    ├── Play Controls
    ├── Progress Bar
    └── Volume Control
```

## Request/Response Flow

```
Frontend Component
       │
       │ 1. User Action
       │
       ▼
   Service Layer
       │
       │ 2. HTTP Request
       │
       ▼
HTTP Interceptor
       │
       │ 3. Add JWT Token
       │
       ▼
   Backend API
       │
       │ 4. JWT Filter
       │
       ▼
Security Filter Chain
       │
       │ 5. Validate Token
       │
       ▼
   Controller
       │
       │ 6. Process Request
       │
       ▼
Service Layer (Backend)
       │
       │ 7. Business Logic
       │
       ▼
   Repository
       │
       │ 8. Database Query
       │
       ▼
   PostgreSQL
       │
       │ 9. Return Data
       │
       ▼
   Repository
       │
       │ 10. Map to Entity
       │
       ▼
Service Layer (Backend)
       │
       │ 11. Process Data
       │
       ▼
   Controller
       │
       │ 12. Return Response
       │
       ▼
   Frontend Service
       │
       │ 13. Update Component
       │
       ▼
Frontend Component
       │
       │ 14. Render UI
       │
       ▼
    User Sees Result
```

## Deployment Architecture

```
┌─────────────────────────────────────────────────────────┐
│                    PRODUCTION                            │
│                                                          │
│  ┌────────────────────────────────────────────────┐    │
│  │              Nginx Reverse Proxy               │    │
│  │              (Port 80/443)                     │    │
│  └───────┬──────────────────────────┬─────────────┘    │
│          │                          │                   │
│          │ /api/*                   │ /*                │
│          │                          │                   │
│  ┌───────▼──────────┐      ┌────────▼──────────┐       │
│  │  Spring Boot     │      │  Angular Static   │       │
│  │  (Port 8081)     │      │  Files            │       │
│  └───────┬──────────┘      └───────────────────┘       │
│          │                                              │
│          │ JDBC                                         │
│          │                                              │
│  ┌───────▼──────────┐                                  │
│  │  PostgreSQL      │                                  │
│  │  (Port 5432)     │                                  │
│  └──────────────────┘                                  │
│                                                          │
│  ┌──────────────────┐                                  │
│  │  File Storage    │                                  │
│  │  /var/uploads/   │                                  │
│  └──────────────────┘                                  │
└─────────────────────────────────────────────────────────┘
```

## Security Layers

```
┌─────────────────────────────────────────────────────────┐
│                    Security Layers                       │
│                                                          │
│  Layer 1: HTTPS/TLS                                     │
│  ├─ Encrypted communication                             │
│  └─ Certificate validation                              │
│                                                          │
│  Layer 2: CORS                                          │
│  ├─ Origin validation                                   │
│  └─ Allowed methods/headers                             │
│                                                          │
│  Layer 3: JWT Authentication                            │
│  ├─ Token validation                                    │
│  ├─ Signature verification                              │
│  └─ Expiration check                                    │
│                                                          │
│  Layer 4: Role-Based Access                             │
│  ├─ USER role permissions                               │
│  └─ ARTIST role permissions                             │
│                                                          │
│  Layer 5: Input Validation                              │
│  ├─ File type validation                                │
│  ├─ File size limits                                    │
│  └─ Data sanitization                                   │
│                                                          │
│  Layer 6: Database Security                             │
│  ├─ Prepared statements                                 │
│  ├─ SQL injection prevention                            │
│  └─ Connection encryption                               │
└─────────────────────────────────────────────────────────┘
```

This visual guide provides a clear understanding of how RevPlay components interact and how data flows through the system.
