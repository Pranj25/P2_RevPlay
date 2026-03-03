@echo off
cls
echo.
echo  ╔═══════════════════════════════════════════════════════════╗
echo  ║                                                           ║
echo  ║         🎵  RevPlay - Start Both Servers  🎵              ║
echo  ║                                                           ║
echo  ╚═══════════════════════════════════════════════════════════╝
echo.

REM Check if MySQL is running
echo [1/4] Checking MySQL...
sc query MySQL80 | find "RUNNING" >nul
if errorlevel 1 (
    echo ❌ ERROR: MySQL is not running!
    echo.
    echo Please start MySQL service:
    echo   - Open Services (services.msc)
    echo   - Find MySQL80
    echo   - Click Start
    echo.
    pause
    exit /b 1
)
echo ✓ MySQL is running
echo.

REM Check if database exists
echo [2/4] Checking database...
mysql -u root -pPranjalP@2003 -e "USE revplayProject;" 2>nul
if errorlevel 1 (
    echo ⚠ Database 'revplayProject' not found!
    echo.
    set /p create_db="Do you want to create it now? (Y/N): "
    if /i "%create_db%"=="Y" (
        echo Creating database...
        mysql -u root -pPranjalP@2003 -e "CREATE DATABASE revplayProject CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;"
        echo Running schema...
        mysql -u root -pPranjalP@2003 revplayProject < database\schema.sql
        echo ✓ Database created
    ) else (
        echo Please run SETUP_DATABASE.bat first
        pause
        exit /b 1
    )
)
echo ✓ Database exists
echo.

REM Start Backend
echo [3/4] Starting Backend Server...
echo.
echo Starting Spring Boot on port 8081...
start "RevPlay Backend - Port 8081" cmd /k "cd backend && mvn spring-boot:run"
echo ✓ Backend starting...
echo.
echo Waiting for backend to initialize (15 seconds)...
timeout /t 15 /nobreak >nul
echo.

REM Start Frontend
echo [4/4] Starting Frontend Server...
echo.
echo Starting Angular on port 4200...
start "RevPlay Frontend - Port 4200" cmd /k "cd frontend && npm start"
echo ✓ Frontend starting...
echo.
echo Waiting for frontend to initialize (20 seconds)...
timeout /t 20 /nobreak >nul
echo.

REM Open Browser
echo Opening browser...
timeout /t 5 /nobreak >nul
start http://localhost:4200
echo.

echo  ╔═══════════════════════════════════════════════════════════╗
echo  ║                                                           ║
echo  ║              ✓ RevPlay is Running!                       ║
echo  ║                                                           ║
echo  ╚═══════════════════════════════════════════════════════════╝
echo.
echo  📱 Frontend (Angular):  http://localhost:4200
echo  🔧 Backend (API):       http://localhost:8081
echo  📚 Swagger UI:          http://localhost:8081/swagger-ui.html
echo  📄 API Docs:            http://localhost:8081/api-docs
echo.
echo  Two command windows have opened:
echo    1. Backend Server (Spring Boot) - Port 8081
echo    2. Frontend Server (Angular) - Port 4200
echo.
echo  ⚠ IMPORTANT: Keep both windows open while using RevPlay
echo  ⚠ Close both windows when you're done
echo.
echo  Press any key to exit this window (servers will keep running)
pause >nul
