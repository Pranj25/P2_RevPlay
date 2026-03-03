# Application Architecture

## Overview

RevPlay follows a monolithic full-stack architecture with clear separation between frontend and backend layers.

## Architecture Layers

### 1. Presentation Layer (Frontend - Angular)

**Components:**
- Home, Login, Register
- Songs, Albums, Artists, Playlists
- Profile, Player

**Services:**
- AuthService - Authentication and user management
- SongService - Song operations
- HTTP Interceptors - JWT token injection

**Guards:**
- AuthGuard - Route protection

**Technology:**
- Angular 17 (Standalone Components)
- RxJS for reactive programming
- TypeScript

### 2. API Layer (Backend - Spring Boot)

**Controllers:**
- AuthController - Authentication endpoints
- UserController - User profile management
- SongController - Song CRUD operations
- AlbumController - Album management
- ArtistController - Artist profiles
- PlaylistController - Playlist operations

**Security:**
- JWT-based authentication
- Spring Security configuration
- Role-based access control (USER, ARTIST)

### 3. Business Logic Layer

**Services (to be implemented):**
- UserService
- SongService
- PlaylistService
- FileUploadService

### 4. Data Access Layer

**Repositories (Spring Data JPA):**
- UserRepository
- ArtistRepository
- SongRepository
- AlbumRepository
- PlaylistRepository
- FavoriteRepository

**Models:**
- User, Artist, Song, Album
- Playlist, Favorite, ListeningHistory

### 5. Database Layer

**Database:** PostgreSQL

**Key Features:**
- Relational data model
- Foreign key constraints
- Indexes for performance
- Transaction support

## Communication Flow

```
User → Angular App → HTTP Request → Spring Boot API
                                    ↓
                              JWT Validation
                                    ↓
                              Controller Layer
                                    ↓
                              Service Layer
                                    ↓
                              Repository Layer
                                    ↓
                              PostgreSQL Database
```

## Security Architecture

1. **Authentication:**
   - JWT tokens generated on login
   - Tokens stored in localStorage (frontend)
   - Tokens sent in Authorization header

2. **Authorization:**
   - Role-based access (USER, ARTIST)
   - Method-level security annotations
   - Route guards (frontend)

3. **Password Security:**
   - BCrypt password hashing
   - Secure password storage

## File Storage

- Audio files and images stored in local filesystem
- File paths stored in database
- Served via static file serving

## API Design

- RESTful principles
- JSON request/response format
- HTTP status codes for responses
- CORS enabled for frontend communication

## Scalability Considerations

Current architecture supports:
- Vertical scaling (increase server resources)
- Database connection pooling
- Stateless API (JWT-based)

Future enhancements:
- Microservices architecture
- Cloud storage for media files
- Caching layer (Redis)
- Load balancing
- CDN for static assets

## Development Workflow

1. Database schema design
2. Backend model creation
3. Repository layer implementation
4. Controller and service development
5. Frontend service creation
6. Component development
7. Integration testing

## Deployment Architecture

**Development:**
- Backend: localhost:8080
- Frontend: localhost:4200
- Database: localhost:5432

**Production (Recommended):**
- Backend: Application server (Tomcat embedded)
- Frontend: Nginx/Apache static hosting
- Database: Managed PostgreSQL service
- Reverse proxy for API routing
