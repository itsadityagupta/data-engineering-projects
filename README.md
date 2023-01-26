# ETL Pipeline using Mage AI, Postgres and Polygon API

### Prerequisites

- A python environment
- Docker and docker-compose
- An API key from [Polygon](https://polygon.io/docs/stocks/getting-started)

### About

The application extracts the data from Polygon API, transforms it and loads them into a Postgres database.

### Run the Project

- ``pip install -r requirements.txt``
- ``docker-compose up --build`` or ``make up``
- Edit ``etl\data_loaders\polygon_key.py`` and populate `POLYGON_KEY` value with your polygon key.
- ``mage start etl``
- Mage UI will open with a pipeline named `initial load`.
- Press the execute pipeline to run the pipeline.

![](ezgif.com-gif-maker.gif)


