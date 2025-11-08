from django.contrib import admin
from .models import FirstModel


@admin.register(FirstModel)
class FirstModelAdmin(admin.ModelAdmin):
    list_display = ('name', 'created_at')
    list_filter = ('created_at',)
    search_fields = ('name', 'description')
