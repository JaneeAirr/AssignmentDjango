# Скрипт для создания Django проекта с нуля
# Использование: .\scripts\create_project.ps1

Write-Host "=== Создание Django проекта ===" -ForegroundColor Green

# Проверка наличия Python
Write-Host "Проверка Python..." -ForegroundColor Yellow
try {
    $pythonVersion = python --version
    Write-Host "Найден: $pythonVersion" -ForegroundColor Green
} catch {
    Write-Host "Ошибка: Python не установлен!" -ForegroundColor Red
    exit 1
}

# Создание виртуального окружения
Write-Host "`nСоздание виртуального окружения..." -ForegroundColor Yellow
if (Test-Path "venv") {
    Write-Host "Виртуальное окружение уже существует" -ForegroundColor Yellow
} else {
    python -m venv venv
    Write-Host "Виртуальное окружение создано" -ForegroundColor Green
}

# Активация виртуального окружения
Write-Host "`nАктивация виртуального окружения..." -ForegroundColor Yellow
& .\venv\Scripts\Activate.ps1

# Установка зависимостей
Write-Host "`nУстановка зависимостей..." -ForegroundColor Yellow
pip install --upgrade pip
if (Test-Path "requirements.txt") {
    pip install -r requirements.txt
} else {
    pip install django
    Write-Host "Создание requirements.txt..." -ForegroundColor Yellow
    pip freeze > requirements.txt
}

# Создание миграций
Write-Host "`nСоздание миграций базы данных..." -ForegroundColor Yellow
python manage.py makemigrations
python manage.py migrate

# Создание суперпользователя (опционально)
Write-Host "`n=== Проект успешно создан! ===" -ForegroundColor Green
Write-Host "Для запуска проекта используйте: .\scripts\run_project.ps1" -ForegroundColor Cyan
Write-Host "Для создания суперпользователя: python manage.py createsuperuser" -ForegroundColor Cyan

