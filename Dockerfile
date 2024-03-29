# 使用指定版本的pypy镜像
FROM python:3.9.18-slim-bullseye
# 替换阿里云源
RUN  sed -i 's/deb.debian.org/mirrors.ustc.edu.cn/g' /etc/apt/sources.list \
   &&  apt-get update && apt-get install -y \
    build-essential libgl1-mesa-glx  libglib2.0-0
# 设置工作目录
WORKDIR /app
# 将当前目录下的文件复制到工作目录
COPY . /app
RUN pip install --upgrade pip  -i https://mirror.baidu.com/pypi/simple \
# 安装需要的包
&& pip install --no-cache-dir flask paddlepaddle paddleocr gunicorn gevent -i https://mirror.baidu.com/pypi/simple 
# 命令设置，此处运行你的App主程序
CMD [ "gunicorn", "-c", "gunicorn_config.py", "app:app" ]
