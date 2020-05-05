FROM python:3.6-alpine

RUN adduser -D -g '' uwsgi
RUN mkdir /app
ENV PYTHONPATH $PYTHONPATH:/app

RUN apk add curl

RUN apk update
RUN apk add linux-headers
RUN apk add build-base
RUN apk add postgresql-libs
RUN apk add --virtual .build-deps gcc musl-dev postgresql-dev libffi-dev python3-dev
RUN pip install --upgrade pip
WORKDIR /app
ADD . /app
RUN python3 -m pip install -r requirements.txt --no-cache-dir
RUN apk --purge del .build-deps

CMD su uwsgi -c 'uwsgi uwsgi.ini --thunder-lock'
