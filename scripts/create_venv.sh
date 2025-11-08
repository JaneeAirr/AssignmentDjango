#!/bin/bash
# Скрипт для создания виртуального окружения
# Использование: bash scripts/create_venv.sh

echo "=== Создание виртуального окружения ==="

# Проверка наличия Python
echo "Проверка Python..."
if ! command -v python3 &> /dev/null; then
    echo "Ошибка: Python не установлен!"
    exit 1
fi

python3 --version

# Проверка существования виртуального окружения
if [ -d "venv" ]; then
    echo "Виртуальное окружение уже существует!"
    read -p "Удалить и создать заново? (y/n): " response
    if [ "$response" = "y" ] || [ "$response" = "Y" ]; then
        rm -rf venv
        echo "Старое окружение удалено"
    else
        echo "Операция отменена"
        exit 0
    fi
fi

# Создание виртуального окружения
echo -e "\nСоздание виртуального окружения..."
python3 -m venv venv

if [ -d "venv" ]; then
    echo "Виртуальное окружение успешно создано!"
    echo -e "\nДля активации выполните:"
    echo "source venv/bin/activate"
    echo -e "\nИли используйте скрипт create_project.sh для полной настройки"
else
    echo "Ошибка при создании виртуального окружения!"
    exit 1
fi

