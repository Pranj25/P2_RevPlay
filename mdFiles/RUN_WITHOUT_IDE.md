# How to Run RevPlay Without Eclipse

## You Don't Need Eclipse!

Spring Boot works perfectly from the command line. Here's how:

---

## Method 1: Using Maven (Easiest)

### Step 1: Open Command Prompt
```bash
# Navigate to backend folder
cd backend
```

### Step 2: Run Spring Boot
```bash
mvn spring-boot:run
```

That's it! Backend will start on http://localhost:8081

---

## Method 2: Using the Batch File

Just double-click:
```
START_BOTH_SERVERS.bat
```

This will start both backend and frontend automatically!

---

## Method 3: Build JAR and Run

### Build the JAR:
```bash
cd backend
mvn clean package
```

### Run the JAR:
```bash
java -jar target/revplay-backend-1.0.0.jar
```

---

## For Frontend (Angular)

### Open another Command Prompt:
```bash
cd frontend
npm start
```

Frontend will start on http://localhost:4200

---

## Alternative IDEs (If you want an IDE)

### 1. IntelliJ IDEA Community (Free & Best for Spring Boot)
- Download: https://www.jetbrains.com/idea/download/
- Open backend folder
- Right-click RevPlayApplication.java → Run

### 2. VS Code (Free & Lightweight)
- Download: https://code.visualstudio.com/
- Install extensions:
  - Spring Boot Extension Pack
  - Java Extension Pack
- Open backend folder
- Press F5 to run

### 3. Spring Tool Suite (Eclipse-based, Free)
- Download: https://spring.io/tools
- Specifically designed for Spring Boot
- Works like Eclipse but with Spring support

---

## Recommended: Use Command Line

**Easiest way:**
1. Open Command Prompt
2. Run: `START_BOTH_SERVERS.bat`
3. Wait 35 seconds
4. Browser opens automatically!

**No IDE needed!** ✅

---

## Troubleshooting

### "mvn: command not found"
**Solution**: Maven is not installed or not in PATH

**Fix**:
1. Download Maven: https://maven.apache.org/download.cgi
2. Extract to C:\Program Files\Maven
3. Add to PATH:
   - Search "Environment Variables"
   - Edit "Path"
   - Add: C:\Program Files\Maven\bin
4. Restart Command Prompt
5. Test: `mvn --version`

### "JAVA_HOME not set"
**Solution**: Java not configured

**Fix**:
1. Find Java installation: `C:\Program Files\Java\jdk-17`
2. Set JAVA_HOME:
   - Search "Environment Variables"
   - New System Variable
   - Name: JAVA_HOME
   - Value: C:\Program Files\Java\jdk-17
3. Restart Command Prompt
4. Test: `java -version`

---

## Summary

**You don't need Eclipse!**

**Easiest method:**
```bash
START_BOTH_SERVERS.bat
```

**Manual method:**
```bash
# Terminal 1 - Backend
cd backend
mvn spring-boot:run

# Terminal 2 - Frontend
cd frontend
npm start
```

**Access:**
- Frontend: http://localhost:4200
- Backend: http://localhost:8081
- Swagger: http://localhost:8081/swagger-ui.html

Eclipse is not required for Spring Boot! Command line works perfectly! 🚀
