@echo off
cls
echo.
echo  ╔═══════════════════════════════════════════════════════════╗
echo  ║                                                           ║
echo  ║              🎵  RevPlay Quick Start  🎵                  ║
echo  ║                                                           ║
echo  ╚═══════════════════════════════════════════════════════════╝
echo.
echo.
echo  What would you like to do?
echo.
echo  [1] Setup Database (First time only)
echo  [2] Start Both Servers (Backend + Frontend)
echo  [3] Start Backend Only
echo  [4] Start Frontend Only (Angular)
echo  [5] Open Swagger API Documentation
echo  [6] View Application URLs
echo  [7] Exit
echo.
set /p choice="Enter your choice (1-7): "

if "%choice%"=="1" goto setup_db
if "%choice%"=="2" goto start_all
if "%choice%"=="3" goto start_backend
if "%choice%"=="4" goto start_angular
if "%choice%"=="5" goto open_swagger
if "%choice%"=="6" goto show_urls
if "%choice%"=="7" goto end

echo Invalid choice!
pause
goto start

:setup_db
cls
echo Running database setup...
call SETUP_DATABASE.bat
goto start

:start_all
cls
echo Starting Both Servers...
call START_BOTH_SERVERS.bat
goto end

:start_backend
cls
echo Starting Backend...
echo.
echo Backend will start on: http://localhost:8081
echo Swagger UI: http://localhost:8081/swagger-ui.html
echo.
echo Press Ctrl+C to stop the backend
echo.
cd backend
mvn spring-boot:run
goto end

:start_angular
cls
echo Starting Angular Frontend...
echo.
echo Frontend will start on: http://localhost:4200
echo.
echo Press Ctrl+C to stop the frontend
echo.
cd frontend
call npm start
goto end

:open_swagger
start http://localhost:8081/swagger-ui.html
echo Swagger UI opened in browser
timeout /t 2 >nul
goto start

:show_urls
cls
echo.
echo  ╔═══════════════════════════════════════════════════════════╗
echo  ║                  Application URLs                         ║
echo  ╚═══════════════════════════════════════════════════════════╝
echo.
echo  Frontend (Angular):  http://localhost:4200
echo  Backend API:         http://localhost:8081
echo  Swagger UI:          http://localhost:8081/swagger-ui.html
echo  API Docs JSON:       http://localhost:8081/api-docs
echo  API Landing Page:    http://localhost:8081/
echo.
echo  Database:            localhost:3306/revplayProject
echo  Username:            root
echo  Password:            PranjalP@2003
echo.
pause
goto start

:end
echo.
echo Thank you for using RevPlay! 🎵
echo.
timeout /t 2 >nul
