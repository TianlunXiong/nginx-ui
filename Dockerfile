FROM python:3.7-alpine

ADD requirements.txt .

RUN sed -i 's/dl-cdn.alpinelinux.org/mirrors.ustc.edu.cn/g' /etc/apk/repositories
RUN apk add python3-dev build-base linux-headers pcre-dev && pip install --no-cache-dir -r requirements.txt

# adding application files
ADD . /webapp

# configure path /webapp to HOME-dir
ENV HOME /webapp
WORKDIR /webapp

ENTRYPOINT ["uwsgi"]
CMD ["--http", "0.0.0.0:8080", "--wsgi-file", "wsgi.py", "--callable", "app", "--processes", "1", "--threads", "8"]