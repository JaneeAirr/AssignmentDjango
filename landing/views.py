from django.shortcuts import render


def home(request):
    """Главная страница"""
    return render(request, 'landing/home.html')


def about(request):
    """Страница о компании"""
    return render(request, 'landing/about.html')


def contacts(request):
    """Страница контактов"""
    return render(request, 'landing/contacts.html')

