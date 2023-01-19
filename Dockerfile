FROM python:3.9.1

ARG PG_USER
ARG PG_PASSWORD
ARG PG_HOST
ARG PG_DB
ARG PG_TABLE
ARG PG_PORT
ARG PG_URL

ENV PG_USER_ENV=$PG_USER
ENV PG_PASSWORD_ENV=$PG_PASSWORD
ENV PG_HOST_ENV=$PG_HOST
ENV PG_DB_ENV=$PG_DB
ENV PG_TABLE_ENV=$PG_TABLE
ENV PG_PORT_ENV=$PG_PORT
ENV PG_URL_ENV=$PG_URL

RUN pip install pandas sqlalchemy requests psycopg2

WORKDIR /app
COPY ingest_data.py ingest_data.py

ENTRYPOINT "python" "ingest_data.py" "--user" ${PG_USER_ENV} "--password" ${PG_PASSWORD_ENV} "--host" ${PG_HOST_ENV} "--port" ${PG_PORT_ENV} "--db" ${PG_DB_ENV} "--table-name" ${PG_TABLE_ENV} "--url" ${PG_URL_ENV}