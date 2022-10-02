wsgi_app = 'app.wsgi:application'
bind = '0.0.0.0:8000'
reload = True
workers = 2
threads = 4
worker_class = 'gthread'
errorlog = '-'
loglevel = 'debug'
