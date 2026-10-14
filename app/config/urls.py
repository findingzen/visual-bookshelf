from django.db import connection
from django.http import HttpResponse
from django.urls import path


def hello(request):
    with connection.cursor() as cursor:
        cursor.execute("SELECT version()")
        (version,) = cursor.fetchone()
    return HttpResponse(
        f"Hello from visual-bookshelf.\n\nDjango is up, and so is {version.split(',')[0]}.\n",
        content_type="text/plain; charset=utf-8",
    )


urlpatterns = [path("", hello)]
