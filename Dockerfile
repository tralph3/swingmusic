FROM node:latest AS CLIENT

RUN git clone https://github.com/geoffrey45/swing-client.git client

WORKDIR /client

RUN yarn install

RUN yarn build

FROM python:latest

WORKDIR /app/swingmusic

COPY . .

COPY --from=CLIENT /client/dist/ client

EXPOSE 1970/tcp

VOLUME /music

VOLUME /config

RUN pip install poetry

RUN poetry config virtualenvs.create false

RUN poetry install

CMD poetry run python manage.py --host 0.0.0.0
