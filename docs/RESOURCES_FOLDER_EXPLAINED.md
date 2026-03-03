# Spring Boot Resources Folder - Complete Guide

## Overview

The `src/main/resources` folder is a special directory in Spring Boot that contains all non-Java resources needed by your application.

---

## Complete Folder Structure

```
backend/src/main/resources/
├── application.properties              # Main configuration (always loaded)
├── application-dev.properties          # Development profile
├── application-prod.properties         # Production profile
├── static/                             # Public static files
│   ├── css/                           # Stylesheets
│   ├── js/                            # JavaScript files
│   ├── images/                        # Images, icons, logos
│   ├── index.html                     # API landing page
│   └── README.md                      # Documentation
└── templates/                          # Server-side HTML templates
    └── README.md                       # Documentation
```

---

## 1. Why Three Application Properties Files?

### Quick Answer:
Different environments (development, production) need different configurations. Spring Boot profiles let you manage this professionally.

### Detailed Explanation:

#### `application.properties` (Base Configuration)
- **Always loaded first**
- Contains common settings for all environments
- Default configuration when no profile is specified

```properties
spring.application.name=RevPlay
server.port=8081
jwt.secret=revplaysecretkeyrevplaysecretkeyrevplay
```

#### `application-dev.properties` (Development)
- Activated with: `--spring.profiles.active=dev`
- Shows SQL queries for debugging
- Detailed logging
- Local database with simple password

```properties
spring.jpa.show-sql=true
logging.level.com.revplay=DEBUG
spring.datasource.password=PranjalP@2003
```

**When to use**: During development on your local machine

#### `application-prod.properties` (Production)
- Activated with: `--spring.profiles.active=prod`
- Minimal logging for performance
- Environment variables for security
- Production database

```properties
spring.jpa.show-sql=false
logging.level.com.revplay=INFO
spring.datasource.password=${DB_PASSWORD}
```

**When to use**: When deploying to live server

### Benefits:

| Aspect | Development | Production |
|--------|-------------|------------|
| **Logging** | Verbose (DEBUG) | Minimal (INFO) |
| **SQL Queries** | Visible | Hidden |
| **Passwords** | Hardcoded | Environment Variables |
| **Database** | Local MySQL | Production MySQL |
| **Schema Updates** | Auto-update | Validate only |

### How to Switch Profiles:

```bash
# Development
mvn spring-boot:run -Dspring-boot.run.profiles=dev

# Production
java -jar revplay.jar --spring.profiles.active=prod

# Default (no profile)
mvn spring-boot:run
```

---

## 2. Why Static Folder?

### Quick Answer:
Spring Boot automatically serves files from `static/` folder as public web content.

### What Goes in Static Folder:

#### ✅ Should Be in Static:
- **CSS files** - Stylesheets
- **JavaScript files** - Client-side scripts
- **Images** - Logos, icons, backgrounds
- **Uploaded files** - Songs, covers, profile pictures
- **HTML pages** - Landing pages, documentation
- **Swagger UI assets** - API documentation interface

#### ❌ Should NOT Be in Static:
- **Java source code** - Goes in `src/main/java`
- **Configuration files** - Goes in `src/main/resources` root
- **Sensitive files** - Passwords, keys, secrets
- **Angular frontend** - Separate project in `frontend/` folder

### How Static Files Are Served:

```
File Location:                          URL:
static/index.html          →           http://localhost:8081/index.html
static/css/style.css       →           http://localhost:8081/css/style.css
static/images/logo.png     →           http://localhost:8081/images/logo.png
static/js/app.js           →           http://localhost:8081/js/app.js
```

### Current RevPlay Setup:

```
static/
├── css/              # Empty (Angular handles styling)
├── js/               # Empty (Angular handles JavaScript)
├── images/           # For logos, icons
├── index.html        # API landing page (shows API info)
└── README.md         # Documentation
```

**Note**: RevPlay uses Angular for the main frontend (runs on port 4200). The static folder is mainly for:
1. API landing page
2. Swagger UI assets
3. Uploaded files (songs, covers)

---

## 3. Why Templates Folder?

### Quick Answer:
For server-side rendered HTML using template engines (Thymeleaf, Freemarker).

### When to Use Templates:

#### ✅ Use Templates For:
1. **Email Templates** - Welcome emails, password reset
2. **PDF Generation** - Invoices, reports
3. **Server-Side Pages** - Admin dashboards
4. **Dynamic HTML** - Content with server data

#### ❌ Don't Use Templates For:
1. **Main Frontend** - Use Angular (already in `frontend/` folder)
2. **REST API** - Return JSON, not HTML
3. **Static Pages** - Use `static/` folder

### Example Email Template:

```html
<!-- templates/email/welcome.html -->
<!DOCTYPE html>
<html xmlns:th="http://www.thymeleaf.org">
<body>
    <h1>Welcome, <span th:text="${username}">User</span>!</h1>
    <p>Thank you for joining RevPlay!</p>
</body>
</html>
```

```java
// Controller
@Service
public class EmailService {
    public String generateEmail(String username) {
        Context context = new Context();
        context.setVariable("username", username);
        return templateEngine.process("email/welcome", context);
    }
}
```

---

## Complete Resources Folder Purpose

| Folder/File | Purpose | Access | Example |
|-------------|---------|--------|---------|
| `application.properties` | Base config | N/A | Server port, app name |
| `application-dev.properties` | Dev config | `--spring.profiles.active=dev` | Debug logging |
| `application-prod.properties` | Prod config | `--spring.profiles.active=prod` | Env variables |
| `static/` | Public files | Direct URL | CSS, JS, images |
| `static/index.html` | Landing page | `http://localhost:8081/` | API info page |
| `templates/` | Server HTML | Controller | Email templates |

---

## RevPlay Architecture

```
RevPlay Project
│
├── Frontend (Angular)
│   ├── Port: 4200
│   ├── Location: frontend/
│   └── Purpose: User interface
│
└── Backend (Spring Boot)
    ├── Port: 8081
    ├── Location: backend/
    └── Resources:
        ├── application.properties → Configuration
        ├── static/ → API landing page + uploads
        └── templates/ → Email templates (optional)
```

### Request Flow:

```
User Browser
    ↓
http://localhost:4200 (Angular Frontend)
    ↓
Makes API calls to
    ↓
http://localhost:8081/api/* (Spring Boot Backend)
    ↓
Returns JSON data
    ↓
Angular displays to user
```

### Static Files Flow:

```
User uploads song
    ↓
POST http://localhost:8081/api/upload/audio
    ↓
Backend saves to: backend/uploads/songs/
    ↓
Returns URL: http://localhost:8081/songs/song123.mp3
    ↓
Angular plays audio from that URL
```

---

## Common Questions

### Q: Why not put everything in one application.properties?
**A**: Different environments need different settings. Development needs debugging, production needs security. Profiles keep them organized.

### Q: Why have static folder if we use Angular?
**A**: 
1. API landing page (http://localhost:8081/)
2. Swagger UI assets
3. Uploaded files (songs, covers)
4. Optional: Deploy Angular build here for single-server setup

### Q: Do I need templates folder?
**A**: Only if you need server-side HTML (emails, PDFs). For REST API + Angular, it's optional.

### Q: Can I delete unused folders?
**A**: Yes, but keep the structure for future needs:
- Keep `static/` for uploads and API landing page
- Keep `templates/` for future email features
- Keep all three `.properties` files for proper deployment

### Q: Where do uploaded files go?
**A**: Configure in `application.properties`:
```properties
spring.web.resources.static-locations=classpath:/static/,file:songs/,file:covers/
```
Files go to:
- `backend/songs/` - Audio files
- `backend/covers/` - Cover images
- `backend/profiles/` - Profile pictures

---

## Best Practices

### ✅ DO:
- Use profiles for different environments
- Keep sensitive data in environment variables (production)
- Use static folder for public files only
- Document your configuration
- Version control all property files

### ❌ DON'T:
- Put production passwords in property files
- Store sensitive files in static folder
- Mix development and production configs
- Commit secrets to Git
- Use same database for dev and prod

---

## Summary

**Three Properties Files**: Different environments need different configurations (dev vs prod)

**Static Folder**: Public files served directly by Spring Boot (CSS, JS, images, uploads)

**Templates Folder**: Server-side HTML rendering (emails, PDFs, admin pages)

**RevPlay Setup**: Angular frontend (port 4200) + Spring Boot API (port 8081) + Static resources for uploads and API docs
