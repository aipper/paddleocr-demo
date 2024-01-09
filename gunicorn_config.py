import multiprocessing

bind = '0.0.0.0:8000'

workers = multiprocessing.cpu_count() * 2 + 1


worker_class = 'gevent'

worker_connections = 1000

proc_name = 'gunicorn'

accesslog = "/var/log/gunicorn/access.log" # 访问日志文件的路径
errorlog = "/var/log/gunicorn/error.log"   # 错误日志文件的路径
loglevel = "info"                         # 日志级别