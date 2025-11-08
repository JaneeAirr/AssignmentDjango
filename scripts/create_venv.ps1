# Скрипт для создания виртуального окружения
# Использование: .\scripts\create_venv.ps1

Write-Host "=== Создание виртуального окружения ===" -ForegroundColor Green

# Проверка наличия Python
Write-Host "Проверка Python..." -ForegroundColor Yellow
try {
    $pythonVersion = python --version
    Write-Host "Найден: $pythonVersion" -ForegroundColor Green
} catch {
    Write-Host "Ошибка: Python не установлен!" -ForegroundColor Red
    exit 1
}

# Проверка существования виртуального окружения
if (Test-Path "venv") {
    Write-Host "Виртуальное окружение уже существует!" -ForegroundColor Yellow
    $response = Read-Host "Удалить и создать заново? (y/n)"
    if ($response -eq "y" -or $response -eq "Y") {
        Remove-Item -Recurse -Force venv
        Write-Host "Старое окружение удалено" -ForegroundColor Yellow
    } else {
        Write-Host "Операция отменена" -ForegroundColor Yellow
        exit 0
    }
}

# Создание виртуального окружения
Write-Host "`nСоздание виртуального окружения..." -ForegroundColor Yellow
python -m venv venv

if (Test-Path "venv") {
    Write-Host "Виртуальное окружение успешно создано!" -ForegroundColor Green
    Write-Host "`nДля активации выполните:" -ForegroundColor Cyan
    Write-Host ".\venv\Scripts\Activate.ps1" -ForegroundColor Cyan
    Write-Host "`nИли используйте скрипт create_project.ps1 для полной настройки" -ForegroundColor Cyan
} else {
    Write-Host "Ошибка при создании виртуального окружения!" -ForegroundColor Red
    exit 1
}

