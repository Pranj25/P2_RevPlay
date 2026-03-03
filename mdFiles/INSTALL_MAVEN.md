# How to Install Maven (If Not Installed)

## Check if Maven is Already Installed

Open Command Prompt and run:
```bash
mvn --version
```

If you see version information, Maven is already installed! ✅

If you see "mvn is not recognized", follow the steps below:

---

## Installation Steps

### Step 1: Download Maven

1. Go to: https://maven.apache.org/download.cgi
2. Download: **apache-maven-3.9.6-bin.zip** (or latest version)
3. Save to Downloads folder

### Step 2: Extract Maven

1. Extract the ZIP file
2. Move the folder to: `C:\Program Files\Maven`
3. Final path should be: `C:\Program Files\Maven\apache-maven-3.9.6`

### Step 3: Set Environment Variables

#### Option A: Using GUI

1. Press `Windows + R`
2. Type: `sysdm.cpl` and press Enter
3. Click "Advanced" tab
4. Click "Environment Variables"
5. Under "System variables", click "New"
6. Add:
   - Variable name: `MAVEN_HOME`
   - Variable value: `C:\Program Files\Maven\apache-maven-3.9.6`
7. Find "Path" variable, click "Edit"
8. Click "New"
9. Add: `%MAVEN_HOME%\bin`
10. Click OK on all windows

#### Option B: Using Command Prompt (Admin)

```bash
setx MAVEN_HOME "C:\Program Files\Maven\apache-maven-3.9.6" /M
setx PATH "%PATH%;%MAVEN_HOME%\bin" /M
```

### Step 4: Verify Installation

1. **Close and reopen** Command Prompt
2. Run:
```bash
mvn --version
```

You should see:
```
Apache Maven 3.9.6
Maven home: C:\Program Files\Maven\apache-maven-3.9.6
Java version: 17.x.x
```

✅ Maven is now installed!

---

## Alternative: Use Maven Wrapper (No Installation Needed)

Our project includes Maven Wrapper, so you can run without installing Maven:

### Windows:
```bash
cd backend
mvnw.cmd spring-boot:run
```

### Linux/Mac:
```bash
cd backend
./mvnw spring-boot:run
```

The wrapper will automatically download Maven if needed!

---

## Troubleshooting

### "JAVA_HOME not set"

Maven needs Java. Set JAVA_HOME:

1. Find Java location:
```bash
where java
```

2. Set JAVA_HOME (usually):
```
C:\Program Files\Java\jdk-17
```

3. Add to Environment Variables:
   - Variable name: `JAVA_HOME`
   - Variable value: `C:\Program Files\Java\jdk-17`

4. Restart Command Prompt

### "mvn still not recognized"

1. Make sure you **closed and reopened** Command Prompt
2. Check PATH includes: `%MAVEN_HOME%\bin`
3. Verify MAVEN_HOME is set:
```bash
echo %MAVEN_HOME%
```

---

## Quick Test

After installation, test with our project:

```bash
cd backend
mvn clean install
mvn spring-boot:run
```

If it starts, Maven is working! ✅

---

## Summary

**Option 1: Install Maven** (follow steps above)

**Option 2: Use Maven Wrapper** (no installation)
```bash
cd backend
mvnw.cmd spring-boot:run
```

**Option 3: Use our batch file**
```bash
START_BOTH_SERVERS.bat
```

All three methods work! Choose what's easiest for you! 🚀
