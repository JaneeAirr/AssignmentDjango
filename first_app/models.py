from django.db import models


class FirstModel(models.Model):
    """Модель для первого приложения"""
    name = models.CharField(max_length=100, verbose_name='Название')
    description = models.TextField(blank=True, verbose_name='Описание')
    created_at = models.DateTimeField(auto_now_add=True, verbose_name='Создано')
    
    class Meta:
        verbose_name = 'Первая модель'
        verbose_name_plural = 'Первые модели'
        ordering = ['-created_at']
    
    def __str__(self):
        return self.name
