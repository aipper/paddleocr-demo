# 使用指定版本的pypy镜像
FROM python:3.13-rc-alpine
# 设置工作目录
WORKDIR /app
# 将当前目录下的文件复制到工作目录
COPY . /app
# 安装需要的包
RUN pip install --no-cache-dir flask paddleocr -i https://mirror.baidu.com/pypi/simple
# 预编译Python文件为.pyc文件
RUN find /app -name "*.py" -exec pypy3 -m py_compile "{}" \;
# 命令设置，此处运行你的App主程序
CMD [ "pypy3", "./app.py" ]