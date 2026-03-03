# API Documentation

## Base URL
- Development: `http://localhost:8081/api`
- Production: `https://your-domain.com/api`

## Swagger UI
Interactive API documentation available at: `http://localhost:8081/swagger-ui.html`

## Authentication

All authenticated endpoints require a JWT token in the Authorization header:
```
Authorization: Bearer <your_jwt_token>
```

### Register
**POST** `/auth/register`

Request Body:
```json
{
  "email": "user@example.com",
  "username": "username",
  "password": "password123",
  "role": "USER",
  "artistName": "Artist Name",
  "bio": "Artist bio",
  "genre": "Rock"
}
```

Response:
```json
{
  "token": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9...",
  "user": {
    "id": 1,
    "email": "user@example.com",
    "username": "username",
    "role": "USER"
  }
}
```

### Login
**POST** `/auth/login`

Request Body:
```json
{
  "emailOrUsername": "username",
  "password": "password123"
}
```

## File Upload

### Upload Audio File
**POST** `/upload/audio`

Content-Type: `multipart/form-data`

Parameters:
- `file`: MP3 audio file (max 10MB)

Response:
```json
{
  "filePath": "/songs/uuid-filename.mp3",
  "message": "Audio file uploaded successfully"
}
```

### Upload Cover Image
**POST** `/upload/cover`

Content-Type: `multipart/form-data`

Parameters:
- `file`: JPEG/PNG image (max 5MB)

Response:
```json
{
  "filePath": "/covers/uuid-filename.jpg",
  "message": "Cover image uploaded successfully"
}
```

## Songs

### Get All Songs
**GET** `/songs`

Response:
```json
[
  {
    "id": 1,
    "title": "Song Title",
    "genre": "Rock",
    "duration": 180,
    "audioFile": "/songs/file.mp3",
    "coverImage": "/covers/cover.jpg",
    "visibility": "PUBLIC",
    "playCount": 100,
    "artist": {
      "id": 1,
      "artistName": "Artist Name"
    }
  }
]
```

### Get Song by ID
**GET** `/songs/{id}`

### Increment Play Count
**PUT** `/songs/{id}/play`

## Error Responses

All errors follow this format:
```json
{
  "status": 404,
  "message": "Resource not found",
  "timestamp": "2024-01-01T12:00:00"
}
```

### Common Status Codes
- 200: Success
- 201: Created
- 400: Bad Request
- 401: Unauthorized
- 403: Forbidden
- 404: Not Found
- 413: Payload Too Large
- 500: Internal Server Error
