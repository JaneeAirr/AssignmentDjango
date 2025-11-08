# Скрипт для загрузки проекта на GitHub
# Использование: .\scripts\push_to_github.ps1 [URL_РЕПОЗИТОРИЯ]
# Пример: .\scripts\push_to_github.ps1 https://github.com/username/repository.git

param(
    [string]$RepositoryUrl = ""
)

Write-Host "=== Загрузка проекта на GitHub ===" -ForegroundColor Green

# Проверка наличия git
if (-not (Get-Command git -ErrorAction SilentlyContinue)) {
    Write-Host "Ошибка: Git не установлен!" -ForegroundColor Red
    exit 1
}

# Проверка инициализации репозитория
if (-not (Test-Path ".git")) {
    Write-Host "Инициализация git репозитория..." -ForegroundColor Yellow
    git init
}

# Добавление всех файлов
Write-Host "`nДобавление файлов в git..." -ForegroundColor Yellow
git add .

# Проверка изменений
$status = git status --short
if (-not $status) {
    Write-Host "Нет изменений для коммита" -ForegroundColor Yellow
} else {
    Write-Host "Создание коммита..." -ForegroundColor Yellow
    git commit -m "Update project files"
}

# Настройка remote репозитория
if ($RepositoryUrl) {
    Write-Host "`nНастройка remote репозитория: $RepositoryUrl" -ForegroundColor Yellow
    
    # Проверка существования remote
    $remote = git remote get-url origin 2>$null
    if ($remote) {
        Write-Host "Remote 'origin' уже существует: $remote" -ForegroundColor Yellow
        $response = Read-Host "Изменить на новый URL? (y/n)"
        if ($response -eq "y" -or $response -eq "Y") {
            git remote set-url origin $RepositoryUrl
            Write-Host "Remote URL обновлен" -ForegroundColor Green
        }
    } else {
        git remote add origin $RepositoryUrl
        Write-Host "Remote 'origin' добавлен" -ForegroundColor Green
    }
    
    # Определение ветки
    $branch = git branch --show-current
    if (-not $branch) {
        $branch = "master"
        git branch -M $branch
    }
    
    Write-Host "`nЗагрузка на GitHub (ветка: $branch)..." -ForegroundColor Yellow
    Write-Host "Если это первый push, используйте: git push -u origin $branch" -ForegroundColor Cyan
    
    $response = Read-Host "Выполнить push сейчас? (y/n)"
    if ($response -eq "y" -or $response -eq "Y") {
        git push -u origin $branch
        if ($LASTEXITCODE -eq 0) {
            Write-Host "`nПроект успешно загружен на GitHub!" -ForegroundColor Green
        } else {
            Write-Host "`nОшибка при загрузке. Убедитесь, что:" -ForegroundColor Red
            Write-Host "1. Репозиторий создан на GitHub" -ForegroundColor Yellow
            Write-Host "2. У вас есть права на запись" -ForegroundColor Yellow
            Write-Host "3. Настроена аутентификация (SSH ключ или токен)" -ForegroundColor Yellow
        }
    }
} else {
    Write-Host "`nДля загрузки на GitHub:" -ForegroundColor Cyan
    Write-Host "1. Создайте репозиторий на GitHub" -ForegroundColor Yellow
    Write-Host "2. Выполните команды:" -ForegroundColor Yellow
    Write-Host "   git remote add origin https://github.com/username/repository.git" -ForegroundColor White
    Write-Host "   git push -u origin master" -ForegroundColor White
    Write-Host "`nИли запустите скрипт с URL: .\scripts\push_to_github.ps1 [URL]" -ForegroundColor Cyan
}

