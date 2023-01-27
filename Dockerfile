FROM python:3.9

RUN apt-get update \
    && apt-get install -y --no-install-recommends

WORKDIR app
COPY . .

RUN pip install --upgrade pip
RUN pip install -r requirements.txt --no-cache-dir
RUN dbt deps

EXPOSE 8080
ENTRYPOINT dbt build --profiles-dir profiles && \
           dbt docs generate --profiles-dir profiles && \
           dbt docs serve --profiles-dir profiles
