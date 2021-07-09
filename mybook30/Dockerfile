FROM python:3.8-buster

WORKDIR /src

ADD ./ /src/
RUN pip3 install -r requirements.txt

RUN mkdir db
RUN chmod 777 db
RUN python manage.py collectstatic
RUN python manage.py migrate
RUN chmod 777 ./db/db.sqlite3

RUN useradd -r -s /bin/false uwsgiusr
USER uwsgiusr
ENTRYPOINT ["uwsgi","--ini","/src/uwsgi.ini"]