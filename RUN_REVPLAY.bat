@echo off
echo ========================================
echo    RevPlay Application Launcher
echo ========================================
echo.

REM Check if MySQL is running
echo [1/5] Checking MySQL...
sc query MySQL80 | find "RUNNING" >nul
if errorlevel 1 (
    echo ERROR: MySQL is not running!
    echo Please start MySQL service first.
    pause
    exit /b 1
)
echo MySQL is running ✓
echo.

REM Check if database exists
echo [2/5] Checking database...
mysql -u root -p -e "USE revplay;" 2>nul
if errorlevel 1 (
    echo Database 'revplay' not found!
    echo.
    set /p create_db="Do you want to create it now? (Y/N): "
    if /i "%create_db%"=="Y" (
        echo Creating database...
        mysql -u root -p -e "CREATE DATABASE revplay CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;"
        echo Running schema...
        mysql -u root -p revplay < database\schema.sql
        echo Database created ✓
    ) else (
        echo Please create database manually and run again.
        pause
        exit /b 1
    )
)
echo Database exists ✓
echo.

REM Start Backend
echo [3/5] Starting Backend...
echo This may take a minute...
start "RevPlay Backend" cmd /k "cd backend && mvn spring-boot:run"
echo Waiting for backend to start...
timeout /t 15 /nobreak >nul
echo Backend starting... Check the backend window for status
echo.

REM Start Web Frontend
echo [4/5] Starting Web Frontend...
start "RevPlay Frontend" cmd /k "cd web-version && python -m http.server 8000"
echo Frontend starting...
timeout /t 3 /nobreak >nul
echo.

REM Open Browser
echo [5/5] Opening browser...
timeout /t 5 /nobreak >nul
start http://localhost:8000
echo.

echo ========================================
echo    RevPlay is Starting!
echo ========================================
echo.
echo Backend:  http://localhost:8081
echo Frontend: http://localhost:8000
echo Swagger:  http://localhost:8081/swagger-ui.html
echo.
echo Two command windows have opened:
echo - Backend (Spring Boot)
echo - Frontend (Python HTTP Server)
echo.
echo Keep both windows open while using RevPlay.
echo Close them when you're done.
echo.
echo ========================================
pause
