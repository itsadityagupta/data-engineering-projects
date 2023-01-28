FROM python:3.9

RUN apt-get update \
    && apt-get install -y --no-install-recommends

WORKDIR app
COPY . .

RUN pip install --upgrade pip
RUN pip install -r requirements.txt --no-cache-dir
RUN dbt deps

ENV DBT_USER=default
ENV DBT_HOST=default
ENV DBT_POSTGES_DB=default
ENV DBT_PASSWORD=default
ENV DBT_PORT=1234
ENV DBT_SCHEMA=default

EXPOSE 8080
CMD dbt build --profiles-dir profiles && \
           dbt docs generate --profiles-dir profiles && \
           dbt docs serve --profiles-dir profiles
