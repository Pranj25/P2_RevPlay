@echo off
echo ========================================
echo    RevPlay Database Setup
echo ========================================
echo.

echo This script will:
echo 1. Create the 'revplayProject' database
echo 2. Run the schema to create tables
echo.
echo You will be prompted for MySQL root password twice.
echo.
pause

echo.
echo [1/2] Creating database...
mysql -u root -p -e "CREATE DATABASE IF NOT EXISTS revplayProject CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;"

if errorlevel 1 (
    echo.
    echo ERROR: Failed to create database!
    echo Please check your MySQL root password.
    pause
    exit /b 1
)

echo Database created successfully ✓
echo.

echo [2/2] Running schema...
mysql -u root -p revplayProject < database\schema.sql

if errorlevel 1 (
    echo.
    echo ERROR: Failed to run schema!
    pause
    exit /b 1
)

echo Schema executed successfully ✓
echo.

echo ========================================
echo    Database Setup Complete!
echo ========================================
echo.
echo Verifying tables...
mysql -u root -p revplayProject -e "SHOW TABLES;"
echo.
echo You should see 9 tables listed above.
echo.
echo Next steps:
echo 1. Database is configured in application.properties
echo 2. Password is set to: PranjalP@2003
echo 3. Run RUN_REVPLAY.bat to start the application
echo.
pause
