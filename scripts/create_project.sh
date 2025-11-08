#!/bin/bash
# Скрипт для создания Django проекта с нуля
# Использование: bash scripts/create_project.sh

echo "=== Создание Django проекта ==="

# Проверка наличия Python
echo "Проверка Python..."
if ! command -v python3 &> /dev/null; then
    echo "Ошибка: Python не установлен!"
    exit 1
fi

python3 --version

# Создание виртуального окружения
echo -e "\nСоздание виртуального окружения..."
if [ -d "venv" ]; then
    echo "Виртуальное окружение уже существует"
else
    python3 -m venv venv
    echo "Виртуальное окружение создано"
fi

# Активация виртуального окружения
echo -e "\nАктивация виртуального окружения..."
source venv/bin/activate

# Установка зависимостей
echo -e "\nУстановка зависимостей..."
pip install --upgrade pip
if [ -f "requirements.txt" ]; then
    pip install -r requirements.txt
else
    pip install django
    echo "Создание requirements.txt..."
    pip freeze > requirements.txt
fi

# Создание миграций
echo -e "\nСоздание миграций базы данных..."
python manage.py makemigrations
python manage.py migrate

# Создание суперпользователя (опционально)
echo -e "\n=== Проект успешно создан! ==="
echo "Для запуска проекта используйте: bash scripts/run_project.sh"
echo "Для создания суперпользователя: python manage.py createsuperuser"

