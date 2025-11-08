#!/bin/bash
# Скрипт для запуска Django проекта
# Использование: bash scripts/run_project.sh

echo "=== Запуск Django проекта ==="

# Проверка виртуального окружения
if [ ! -d "venv" ]; then
    echo "Ошибка: Виртуальное окружение не найдено!"
    echo "Сначала выполните: bash scripts/create_project.sh"
    exit 1
fi

# Активация виртуального окружения
echo "Активация виртуального окружения..."
source venv/bin/activate

# Проверка зависимостей
echo "Проверка зависимостей..."
pip install -r requirements.txt --quiet

# Запуск сервера разработки
echo -e "\nЗапуск сервера разработки..."
echo "Сервер будет доступен по адресу: http://127.0.0.1:8000"
echo "Для остановки нажмите Ctrl+C\n"

python manage.py runserver

