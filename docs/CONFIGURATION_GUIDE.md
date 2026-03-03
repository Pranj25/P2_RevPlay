# Spring Boot Configuration Guide

## Why Multiple Application Properties Files?

Spring Boot uses **profiles** to manage different configurations for different environments. This is a best practice for professional applications.

### The Three Files Explained:

#### 1. `application.properties` (Main/Default)
- **Purpose**: Default configuration that applies to ALL environments
- **When Used**: Always loaded first, regardless of active profile
- **Contains**: Common settings shared across all environments
- **Example Use**: Local development, testing on your machine

```properties
spring.application.name=RevPlay
server.port=8081
jwt.secret=revplaysecretkeyrevplaysecretkeyrevplay
```

#### 2. `application-dev.properties` (Development Profile)
- **Purpose**: Development-specific settings
- **When Used**: When you run with `--spring.profiles.active=dev`
- **Contains**: 
  - Debug logging enabled
  - Show SQL queries
  - Relaxed security
  - Local database connection
- **Example Use**: During active development

```properties
spring.jpa.show-sql=true
logging.level.com.revplay=DEBUG
```

**How to activate:**
```bash
java -jar app.jar --spring.profiles.active=dev
```

#### 3. `application-prod.properties` (Production Profile)
- **Purpose**: Production-specific settings
- **When Used**: When deployed to production server
- **Contains**:
  - Environment variables for security
  - Minimal logging
  - Strict validation
  - Production database connection
- **Example Use**: Live server deployment

```properties
spring.jpa.show-sql=false
logging.level.com.revplay=INFO
spring.datasource.url=${DB_URL}
spring.datasource.password=${DB_PASSWORD}
```

**How to activate:**
```bash
java -jar app.jar --spring.profiles.active=prod
```

---

## Profile Loading Order

Spring Boot loads properties in this order (later overrides earlier):

1. `application.properties` (base configuration)
2. `application-{profile}.properties` (profile-specific)

**Example:**
```
application.properties:
  server.port=8081
  logging.level=INFO

application-dev.properties:
  logging.level=DEBUG  ← This overrides INFO when dev profile is active
```

---

## Benefits of Multiple Profiles

### 1. **Security**
- Production passwords stored as environment variables
- Development uses simple passwords
- No sensitive data in version control

### 2. **Debugging**
- Development: Detailed logs, SQL queries visible
- Production: Minimal logs, better performance

### 3. **Database Management**
- Development: Auto-create tables, update schema
- Production: Validate only, no auto-changes

### 4. **Flexibility**
- Easy to switch between environments
- No code changes needed
- Same JAR file works everywhere

---

## Common Profile Configurations

### Development Profile Features:
```properties
# Show all SQL queries
spring.jpa.show-sql=true
spring.jpa.properties.hibernate.format_sql=true

# Auto-update database schema
spring.jpa.hibernate.ddl-auto=update

# Debug logging
logging.level.com.revplay=DEBUG
logging.level.org.springframework.security=DEBUG

# Local database
spring.datasource.url=jdbc:mysql://localhost:3306/revplayProject
spring.datasource.username=root
spring.datasource.password=PranjalP@2003
```

### Production Profile Features:
```properties
# Hide SQL queries
spring.jpa.show-sql=false

# Don't modify database schema
spring.jpa.hibernate.ddl-auto=validate

# Minimal logging
logging.level.com.revplay=INFO

# Environment-based database
spring.datasource.url=${DB_URL}
spring.datasource.username=${DB_USERNAME}
spring.datasource.password=${DB_PASSWORD}
```

---

## How to Use Profiles

### In IDE (IntelliJ IDEA / Eclipse):
1. Edit Run Configuration
2. Add VM options: `-Dspring.profiles.active=dev`
3. Or add Program arguments: `--spring.profiles.active=dev`

### In Command Line:
```bash
# Development
mvn spring-boot:run -Dspring-boot.run.profiles=dev

# Production
java -jar revplay.jar --spring.profiles.active=prod
```

### In application.properties:
```properties
# Set default profile
spring.profiles.active=dev
```

---

## Best Practices

### ✅ DO:
- Use environment variables for sensitive data in production
- Keep development settings simple and visible
- Use different databases for dev/prod
- Enable debug logging only in development
- Version control dev/prod property files

### ❌ DON'T:
- Put production passwords in property files
- Use same database for dev and prod
- Enable debug logging in production
- Commit sensitive credentials to Git

---

## Environment Variables in Production

Instead of hardcoding values, use environment variables:

```properties
# application-prod.properties
spring.datasource.url=${DB_URL:jdbc:mysql://localhost:3306/revplayProject}
spring.datasource.username=${DB_USERNAME:root}
spring.datasource.password=${DB_PASSWORD}
jwt.secret=${JWT_SECRET}
```

Set environment variables on server:
```bash
export DB_URL="jdbc:mysql://production-server:3306/revplayProject"
export DB_USERNAME="revplay_user"
export DB_PASSWORD="super_secure_password_here"
export JWT_SECRET="production_jwt_secret_key"
```

---

## Additional Profiles (Optional)

You can create more profiles as needed:

### `application-test.properties`
- For automated testing
- Uses H2 in-memory database
- Fast, isolated tests

### `application-staging.properties`
- Pre-production environment
- Similar to production but separate
- For final testing before release

### `application-local.properties`
- Personal developer settings
- Not committed to Git (add to .gitignore)
- Each developer can have their own

---

## Checking Active Profile

Add this to your application:

```java
@SpringBootApplication
public class RevPlayApplication {
    
    @Autowired
    private Environment env;
    
    public static void main(String[] args) {
        SpringApplication.run(RevPlayApplication.class, args);
    }
    
    @PostConstruct
    public void init() {
        String[] profiles = env.getActiveProfiles();
        System.out.println("Active Profiles: " + Arrays.toString(profiles));
    }
}
```

---

## Summary

| File | Purpose | When Used | Logging | Database |
|------|---------|-----------|---------|----------|
| `application.properties` | Default/Base | Always | INFO | Local |
| `application-dev.properties` | Development | Dev mode | DEBUG | Local |
| `application-prod.properties` | Production | Live server | INFO | Production |

**Current Setup**: 
- No profile specified = uses `application.properties` (development mode)
- Add `--spring.profiles.active=dev` for development features
- Add `--spring.profiles.active=prod` for production deployment
