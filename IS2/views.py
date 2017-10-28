from django.shortcuts import render

def home(request):
    '''Vista del menu principal del sistema'''
    return render(request, 'home.html',{})