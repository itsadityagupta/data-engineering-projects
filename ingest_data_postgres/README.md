## CSV File to Postgres Data Pipeline

Homework Link: https://github.com/DataTalksClub/data-engineering-zoomcamp/blob/main/cohorts/2023/week_1_docker_sql/homework.md

- `ingest_data.py`: Python script to download csv files from given urls and save the data in postgres.
- `docker-compose.yml`: Dockerize the `ingest_data.py` pipeline along with running Postgres and PgAdmin.
- `.dockerignore`: Ignore the files while building a docker context.
- `Dockerfile`: Builds a docker image for `ingest_data.py` pipeline.

`homework_queries.sql`: This contains the queries I used to answer the homework questions.

#### Commands to Run

- `docker-compose up`: Runs the Postgres DB, PgAdmin and data ingestion pipeline. The data will be loaded to postgres which can be analyzed using PgAdmin.