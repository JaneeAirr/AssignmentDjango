# Скрипт для запуска Django проекта
# Использование: .\scripts\run_project.ps1

Write-Host "=== Запуск Django проекта ===" -ForegroundColor Green

# Проверка виртуального окружения
if (-not (Test-Path "venv")) {
    Write-Host "Ошибка: Виртуальное окружение не найдено!" -ForegroundColor Red
    Write-Host "Сначала выполните: .\scripts\create_project.ps1" -ForegroundColor Yellow
    exit 1
}

# Активация виртуального окружения
Write-Host "Активация виртуального окружения..." -ForegroundColor Yellow
& .\venv\Scripts\Activate.ps1

# Проверка зависимостей
Write-Host "Проверка зависимостей..." -ForegroundColor Yellow
pip install -r requirements.txt --quiet

# Запуск сервера разработки
Write-Host "`nЗапуск сервера разработки..." -ForegroundColor Yellow
Write-Host "Сервер будет доступен по адресу: http://127.0.0.1:8000" -ForegroundColor Cyan
Write-Host "Для остановки нажмите Ctrl+C`n" -ForegroundColor Yellow

python manage.py runserver

