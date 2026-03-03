# RevPlay Documentation

Comprehensive documentation for the RevPlay music streaming application.

## Documentation Files

### 1. [Architecture Documentation](ARCHITECTURE.md)
Complete system architecture overview including:
- Application layers
- Technology stack
- Communication flow
- Security architecture
- Deployment architecture

### 2. [Entity Relationship Diagram](ERD.md)
Database design documentation:
- Entity definitions
- Relationships and cardinality
- Table structures
- Foreign key constraints

### 3. [Testing Documentation](TESTING.md)
Testing strategy and guidelines:
- Unit testing approach
- Integration testing
- Test coverage goals
- Manual testing checklist
- API testing examples

### 4. [API Documentation](API_DOCUMENTATION.md)
Complete API reference:
- Endpoint descriptions
- Request/response formats
- Authentication details
- Error handling
- Example requests

## Quick Links

### Getting Started
- [Main README](../README.md) - Project overview and setup
- [Backend README](../backend/README.md) - Backend setup and configuration
- [Frontend README](../frontend/README.md) - Frontend setup and development
- [Database README](../database/README.md) - Database schema and queries

### Features
- [Features List](../FEATURES.md) - Complete list of implemented features

### API Access
- Swagger UI: http://localhost:8081/swagger-ui.html
- API Docs JSON: http://localhost:8081/api-docs

## Project Structure

```
revplay/
├── backend/              # Spring Boot API
│   ├── src/
│   │   ├── main/
│   │   └── test/
│   ├── pom.xml
│   └── README.md
├── frontend/             # Angular application
│   ├── src/
│   ├── package.json
│   └── README.md
├── database/             # Database schema
│   ├── schema.sql
│   └── README.md
├── docs/                 # Documentation
│   ├── ARCHITECTURE.md
│   ├── ERD.md
│   ├── TESTING.md
│   ├── API_DOCUMENTATION.md
│   └── README.md
├── README.md             # Main project README
├── FEATURES.md           # Feature list
└── .gitignore
```

## Technology Stack

### Backend
- Java 17
- Spring Boot 3.2.0
- Spring Security + JWT
- Spring Data JPA
- PostgreSQL
- Swagger/OpenAPI
- Maven

### Frontend
- Angular 17
- TypeScript 5.2
- RxJS 7.8
- HTML5 Audio API
- Standalone Components

### Database
- PostgreSQL 14+

## Development Workflow

### 1. Setup Environment
```bash
# Clone repository
git clone <repository-url>
cd revplay

# Setup database
psql -U postgres -c "CREATE DATABASE revplay;"
psql -U postgres -d revplay -f database/schema.sql

# Setup backend
cd backend
mvn clean install

# Setup frontend
cd ../frontend
npm install
```

### 2. Run Development Servers
```bash
# Terminal 1 - Backend
cd backend
mvn spring-boot:run

# Terminal 2 - Frontend
cd frontend
npm start
```

### 3. Access Application
- Frontend: http://localhost:4200
- Backend API: http://localhost:8081
- Swagger UI: http://localhost:8081/swagger-ui.html

## Key Features

### Authentication
- User registration (User/Artist roles)
- JWT-based authentication
- Role-based access control

### Music Management
- MP3 file upload and storage
- Song metadata management
- Album and artist profiles
- Playlist creation and management

### Music Player
- Real-time audio streaming
- Play/Pause controls
- Seek functionality
- Volume control
- Progress tracking

### API Features
- RESTful API design
- Swagger documentation
- Global exception handling
- Request/response logging
- CORS support

## Testing

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

### Test Coverage
```bash
# Backend
cd backend
mvn test jacoco:report

# Frontend
cd frontend
npm test -- --code-coverage
```

## Deployment

### Development
- Backend: localhost:8081
- Frontend: localhost:4200
- Database: localhost:5432

### Production Considerations
- Use environment variables for sensitive data
- Enable HTTPS
- Configure reverse proxy (Nginx)
- Set up database backups
- Implement monitoring and logging
- Use CDN for static assets

## API Endpoints Summary

### Authentication
- `POST /api/auth/register` - Register user
- `POST /api/auth/login` - Login user

### Songs
- `GET /api/songs` - List all songs
- `GET /api/songs/{id}` - Get song details
- `POST /api/songs` - Create song
- `PUT /api/songs/{id}/play` - Increment play count

### File Upload
- `POST /api/upload/audio` - Upload MP3
- `POST /api/upload/cover` - Upload cover image
- `POST /api/upload/profile` - Upload profile picture

### Albums, Artists, Playlists, Users
See [API Documentation](API_DOCUMENTATION.md) for complete endpoint list.

## Security

### Authentication
- JWT tokens with configurable expiration
- BCrypt password hashing
- Stateless session management

### Authorization
- Role-based access (USER, ARTIST)
- Protected endpoints
- Route guards (frontend)

### File Upload
- File type validation
- File size limits
- Secure file storage

## Performance

### Backend
- Database connection pooling
- JPA query optimization
- Indexed database columns

### Frontend
- Lazy loading
- AOT compilation
- Tree shaking
- Bundle optimization

## Troubleshooting

### Common Issues

#### Database Connection Failed
```bash
# Check PostgreSQL status
sudo systemctl status postgresql

# Verify credentials in application.properties
```

#### Port Already in Use
```bash
# Backend (8081)
lsof -i :8081
kill -9 <PID>

# Frontend (4200)
npx kill-port 4200
```

#### CORS Errors
- Verify CORS configuration in SecurityConfig.java
- Check frontend API URL configuration

#### File Upload Fails
- Check upload directory permissions
- Verify file size limits
- Check file type validation

## Contributing

1. Fork the repository
2. Create feature branch
3. Write tests
4. Update documentation
5. Submit pull request

## Support

For issues and questions:
- Check documentation
- Review API documentation in Swagger
- Check troubleshooting guides
- Create GitHub issue

## License

MIT License - See LICENSE file for details

## Additional Resources

- [Spring Boot Documentation](https://spring.io/projects/spring-boot)
- [Angular Documentation](https://angular.io/docs)
- [PostgreSQL Documentation](https://www.postgresql.org/docs/)
- [JWT Introduction](https://jwt.io/introduction)
- [Swagger/OpenAPI](https://swagger.io/specification/)
