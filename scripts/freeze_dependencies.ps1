# Скрипт для заморозки зависимостей
# Использование: .\scripts\freeze_dependencies.ps1

Write-Host "=== Заморозка зависимостей ===" -ForegroundColor Green

# Проверка виртуального окружения
if (-not (Test-Path "venv")) {
    Write-Host "Ошибка: Виртуальное окружение не найдено!" -ForegroundColor Red
    Write-Host "Сначала создайте виртуальное окружение: .\scripts\create_venv.ps1" -ForegroundColor Yellow
    exit 1
}

# Активация виртуального окружения
Write-Host "Активация виртуального окружения..." -ForegroundColor Yellow
& .\venv\Scripts\Activate.ps1

# Обновление pip
Write-Host "Обновление pip..." -ForegroundColor Yellow
python -m pip install --upgrade pip

# Заморозка зависимостей
Write-Host "`nЗаморозка зависимостей в requirements.txt..." -ForegroundColor Yellow
pip freeze > requirements.txt

if (Test-Path "requirements.txt") {
    Write-Host "Зависимости успешно заморожены!" -ForegroundColor Green
    Write-Host "`nСодержимое requirements.txt:" -ForegroundColor Cyan
    Get-Content requirements.txt
    Write-Host "`nФайл сохранен: requirements.txt" -ForegroundColor Green
} else {
    Write-Host "Ошибка при создании requirements.txt!" -ForegroundColor Red
    exit 1
}

