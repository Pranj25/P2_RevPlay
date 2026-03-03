@echo off
echo ========================================
echo RevPlay Database Cleanup Script
echo ========================================
echo.
echo This script will clean up invalid artist entries
echo from your database (artists with email addresses).
echo.
echo IMPORTANT: Make sure your backend is NOT running!
echo.
pause

echo.
echo Connecting to MySQL...
echo.

mysql -u root -pPranjalP@2003 revplayProject < database\CLEANUP_ARTISTS.sql

echo.
echo ========================================
echo Cleanup Complete!
echo ========================================
echo.
echo The invalid artist entries have been removed.
echo You can now restart your backend server.
echo.
pause
