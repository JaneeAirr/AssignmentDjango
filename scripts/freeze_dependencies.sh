#!/bin/bash
# Скрипт для заморозки зависимостей
# Использование: bash scripts/freeze_dependencies.sh

echo "=== Заморозка зависимостей ==="

# Проверка виртуального окружения
if [ ! -d "venv" ]; then
    echo "Ошибка: Виртуальное окружение не найдено!"
    echo "Сначала создайте виртуальное окружение: bash scripts/create_venv.sh"
    exit 1
fi

# Активация виртуального окружения
echo "Активация виртуального окружения..."
source venv/bin/activate

# Обновление pip
echo "Обновление pip..."
python -m pip install --upgrade pip

# Заморозка зависимостей
echo -e "\nЗаморозка зависимостей в requirements.txt..."
pip freeze > requirements.txt

if [ -f "requirements.txt" ]; then
    echo "Зависимости успешно заморожены!"
    echo -e "\nСодержимое requirements.txt:"
    cat requirements.txt
    echo -e "\nФайл сохранен: requirements.txt"
else
    echo "Ошибка при создании requirements.txt!"
    exit 1
fi

