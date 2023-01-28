FROM python:3.9

RUN apt-get update \
    && apt-get install -y --no-install-recommends

WORKDIR app
COPY . .

RUN pip install --upgrade pip
RUN pip install -r requirements.txt --no-cache-dir
RUN dbt deps

ENV DBT_USER=postgres
ENV DBT_HOST=db
ENV DBT_POSTGES_DB=dvdrental
ENV DBT_PASSWORD=postgres
ENV DBT_PORT=5432
ENV DBT_SCHEMA=analysis

EXPOSE 8080
CMD dbt build --profiles-dir profiles && \
           dbt docs generate --profiles-dir profiles && \
           dbt docs serve --profiles-dir profiles
