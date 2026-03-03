# RevPlay Application Launcher
# PowerShell Script

Write-Host "`n========================================" -ForegroundColor Cyan
Write-Host "   RevPlay Application Launcher" -ForegroundColor Green
Write-Host "========================================`n" -ForegroundColor Cyan

# Check MySQL
Write-Host "[1/5] Checking MySQL..." -ForegroundColor Yellow
$mysqlService = Get-Service -Name MySQL80 -ErrorAction SilentlyContinue
if ($mysqlService.Status -ne 'Running') {
    Write-Host "ERROR: MySQL is not running!" -ForegroundColor Red
    Write-Host "Please start MySQL service first." -ForegroundColor Red
    Read-Host "Press Enter to exit"
    exit 1
}
Write-Host "MySQL is running ✓" -ForegroundColor Green
Write-Host ""

# Check Java
Write-Host "[2/5] Checking Java..." -ForegroundColor Yellow
try {
    $javaVersion = java -version 2>&1 | Select-String "version"
    Write-Host "Java found: $javaVersion" -ForegroundColor Green
} catch {
    Write-Host "ERROR: Java not found!" -ForegroundColor Red
    Read-Host "Press Enter to exit"
    exit 1
}
Write-Host ""

# Check Maven
Write-Host "[3/5] Checking Maven..." -ForegroundColor Yellow
try {
    $mavenVersion = mvn -version 2>&1 | Select-String "Apache Maven"
    Write-Host "Maven found: $mavenVersion" -ForegroundColor Green
} catch {
    Write-Host "ERROR: Maven not found!" -ForegroundColor Red
    Read-Host "Press Enter to exit"
    exit 1
}
Write-Host ""

# Start Backend
Write-Host "[4/5] Starting Backend..." -ForegroundColor Yellow
Write-Host "Opening new window for backend..." -ForegroundColor Cyan
Start-Process powershell -ArgumentList "-NoExit", "-Command", "cd '$PSScriptRoot\backend'; Write-Host 'Starting Spring Boot...' -ForegroundColor Green; mvn spring-boot:run"
Write-Host "Backend starting... (This may take a minute)" -ForegroundColor Green
Start-Sleep -Seconds 15
Write-Host ""

# Start Frontend
Write-Host "[5/5] Starting Web Frontend..." -ForegroundColor Yellow
Write-Host "Opening new window for frontend..." -ForegroundColor Cyan
Start-Process powershell -ArgumentList "-NoExit", "-Command", "cd '$PSScriptRoot\web-version'; Write-Host 'Starting HTTP Server...' -ForegroundColor Green; python -m http.server 8000"
Write-Host "Frontend starting..." -ForegroundColor Green
Start-Sleep -Seconds 5
Write-Host ""

# Open Browser
Write-Host "Opening browser..." -ForegroundColor Yellow
Start-Sleep -Seconds 5
Start-Process "http://localhost:8000"
Write-Host ""

Write-Host "========================================" -ForegroundColor Cyan
Write-Host "   RevPlay is Starting!" -ForegroundColor Green
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""
Write-Host "Backend:  http://localhost:8081" -ForegroundColor White
Write-Host "Frontend: http://localhost:8000" -ForegroundColor White
Write-Host "Swagger:  http://localhost:8081/swagger-ui.html" -ForegroundColor White
Write-Host ""
Write-Host "Two PowerShell windows have opened:" -ForegroundColor Yellow
Write-Host "- Backend (Spring Boot)" -ForegroundColor White
Write-Host "- Frontend (Python HTTP Server)" -ForegroundColor White
Write-Host ""
Write-Host "Keep both windows open while using RevPlay." -ForegroundColor Yellow
Write-Host "Close them when you're done." -ForegroundColor Yellow
Write-Host ""
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""
Read-Host "Press Enter to close this window"
