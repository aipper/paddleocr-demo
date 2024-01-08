# 使用指定版本的pypy镜像
FROM pypy:3.10-slim-bullseye
# 替换阿里云源
RUN echo 'deb http://mirrors.aliyun.com/debian/ bullseye main non-free contrib\n\
deb-src http://mirrors.aliyun.com/debian/ bullseye main non-free contrib\n\
deb http://mirrors.aliyun.com/debian-security bullseye/updates main\n\
deb-src http://mirrors.aliyun.com/debian-security bullseye/updates main\n\
deb http://mirrors.aliyun.com/debian/ bullseye-updates main non-free contrib\n\
deb-src http://mirrors.aliyun.com/debian/ bullseye-updates main non-free contrib\n\
deb http://mirrors.aliyun.com/debian/ bullseye-backports main non-free contrib\n\
deb-src http://mirrors.aliyun.com/debian/ bullseye-backports main non-free contrib' > /etc/apt/sources.list \
   &&  apt-get update && apt-get install -y \
    build-essential
# 设置工作目录
WORKDIR /app
# 将当前目录下的文件复制到工作目录
COPY . /app
RUN pip install --upgrade pip  -i https://mirror.baidu.com/pypi/simple \
# 安装需要的包
&& pip install --no-cache-dir flask paddleocr numpy -i https://mirror.baidu.com/pypi/simple
# 预编译Python文件为.pyc文件
RUN find /app -name "*.py" -exec pypy3 -m py_compile "{}" \;
# 命令设置，此处运行你的App主程序
CMD [ "pypy3", "./app.py" ]