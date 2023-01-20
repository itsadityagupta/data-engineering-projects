import argparse
import pandas as pd
import requests
from sqlalchemy import create_engine
from time import time


def download_csv(url):
    file_name = url.split("/")[-1]
    # downloading zip file
    with open(file_name, 'wb') as f:
        response = requests.get(url)
        f.write(response.content)
    return file_name


def save_to_postgres(params):
    user = params.user
    password = params.password
    host = params.host
    port = int(params.port)
    db = params.db
    table_name = params.table_name
    url = params.url
    csv_name = download_csv(url)

    engine = create_engine(f'postgresql://{user}:{password}@{host}:{port}/{db}')
    # read_csv reads both .csv files and .csv.gz files
    df_iter = pd.read_csv(csv_name, iterator=True, chunksize=100000)

    df = next(df_iter)
    # creating the database
    df.head(n=0).to_sql(name=table_name, con=engine, if_exists='replace')

    df.tpep_pickup_datetime = pd.to_datetime(df.tpep_pickup_datetime)
    df.tpep_dropoff_datetime = pd.to_datetime(df.tpep_dropoff_datetime)

    start_time = time()
    df.to_sql(name=table_name, con=engine, if_exists='append')
    end_time = time()
    print("chuk inserted...took {%.3f}"%(end_time - start_time))

    while True:
        df = next(df_iter)

        df.tpep_pickup_datetime = pd.to_datetime(df.tpep_pickup_datetime)
        df.tpep_dropoff_datetime = pd.to_datetime(df.tpep_dropoff_datetime)

        start_time = time()
        df.to_sql(name=table_name, con=engine, if_exists='append')
        end_time = time()
        print("chuk inserted...took %.3f seconds." % (end_time - start_time))


if __name__ == '__main__':
    parser = argparse.ArgumentParser(description="Ingest CSV data to postgres")

    parser.add_argument("--user", "-u", help="username for postgres")
    parser.add_argument("--password", help="password for postgres")
    parser.add_argument("--host", help="host for postgres")
    parser.add_argument("--port", help="port for postgres")
    parser.add_argument("--db", help="database for postgres")
    parser.add_argument("--table-name", help="output table name")
    parser.add_argument("--url", help="url to csv file")

    args = parser.parse_args()

    save_to_postgres(args)


