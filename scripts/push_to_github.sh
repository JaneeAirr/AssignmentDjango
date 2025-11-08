#!/bin/bash
# Скрипт для загрузки проекта на GitHub
# Использование: bash scripts/push_to_github.sh [URL_РЕПОЗИТОРИЯ]
# Пример: bash scripts/push_to_github.sh https://github.com/username/repository.git

REPOSITORY_URL=$1

echo "=== Загрузка проекта на GitHub ==="

# Проверка наличия git
if ! command -v git &> /dev/null; then
    echo "Ошибка: Git не установлен!"
    exit 1
fi

# Проверка инициализации репозитория
if [ ! -d ".git" ]; then
    echo "Инициализация git репозитория..."
    git init
fi

# Добавление всех файлов
echo -e "\nДобавление файлов в git..."
git add .

# Проверка изменений
if [ -z "$(git status --short)" ]; then
    echo "Нет изменений для коммита"
else
    echo "Создание коммита..."
    git commit -m "Update project files"
fi

# Настройка remote репозитория
if [ -n "$REPOSITORY_URL" ]; then
    echo -e "\nНастройка remote репозитория: $REPOSITORY_URL"
    
    # Проверка существования remote
    if git remote get-url origin &> /dev/null; then
        REMOTE=$(git remote get-url origin)
        echo "Remote 'origin' уже существует: $REMOTE"
        read -p "Изменить на новый URL? (y/n): " response
        if [ "$response" = "y" ] || [ "$response" = "Y" ]; then
            git remote set-url origin "$REPOSITORY_URL"
            echo "Remote URL обновлен"
        fi
    else
        git remote add origin "$REPOSITORY_URL"
        echo "Remote 'origin' добавлен"
    fi
    
    # Определение ветки
    BRANCH=$(git branch --show-current)
    if [ -z "$BRANCH" ]; then
        BRANCH="master"
        git branch -M "$BRANCH"
    fi
    
    echo -e "\nЗагрузка на GitHub (ветка: $BRANCH)..."
    echo "Если это первый push, используйте: git push -u origin $BRANCH"
    
    read -p "Выполнить push сейчас? (y/n): " response
    if [ "$response" = "y" ] || [ "$response" = "Y" ]; then
        git push -u origin "$BRANCH"
        if [ $? -eq 0 ]; then
            echo -e "\nПроект успешно загружен на GitHub!"
        else
            echo -e "\nОшибка при загрузке. Убедитесь, что:"
            echo "1. Репозиторий создан на GitHub"
            echo "2. У вас есть права на запись"
            echo "3. Настроена аутентификация (SSH ключ или токен)"
        fi
    fi
else
    echo -e "\nДля загрузки на GitHub:"
    echo "1. Создайте репозиторий на GitHub"
    echo "2. Выполните команды:"
    echo "   git remote add origin https://github.com/username/repository.git"
    echo "   git push -u origin master"
    echo -e "\nИли запустите скрипт с URL: bash scripts/push_to_github.sh [URL]"
fi

