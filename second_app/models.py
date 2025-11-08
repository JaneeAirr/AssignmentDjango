from django.db import models


class SecondModel(models.Model):
    """Модель для второго приложения"""
    title = models.CharField(max_length=200, verbose_name='Заголовок')
    content = models.TextField(verbose_name='Содержание')
    is_active = models.BooleanField(default=True, verbose_name='Активно')
    created_at = models.DateTimeField(auto_now_add=True, verbose_name='Создано')
    
    class Meta:
        verbose_name = 'Вторая модель'
        verbose_name_plural = 'Вторые модели'
        ordering = ['-created_at']
    
    def __str__(self):
        return self.title
