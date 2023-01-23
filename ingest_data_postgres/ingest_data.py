import argparse
import pandas as pd
import requests
from sqlalchemy import create_engine
from time import time


def download_csv(url):
    print(f"Downloading {url}")
    file_name = url.split("/")[-1]
    # downloading zip file
    with open(file_name, 'wb') as f:
        response = requests.get(url)
        f.write(response.content)
    return file_name


def save_trips_data(url, engine, table_name):
    filename = download_csv(url)
    df_iter = pd.read_csv(filename, iterator=True, chunksize=100000)

    df = next(df_iter)
    # creating the database
    df.head(n=0).to_sql(name=table_name, con=engine, if_exists='replace')

    df.lpep_pickup_datetime = pd.to_datetime(df.lpep_pickup_datetime)
    df.lpep_dropoff_datetime = pd.to_datetime(df.lpep_dropoff_datetime)

    start_time = time()
    df.to_sql(name=table_name, con=engine, if_exists='append')
    end_time = time()
    print("chuk inserted...took {%.3f}" % (end_time - start_time))

    while True:
        try:
            df = next(df_iter)
        except StopIteration:
            break

        df.lpep_pickup_datetime = pd.to_datetime(df.lpep_pickup_datetime)
        df.lpep_dropoff_datetime = pd.to_datetime(df.lpep_dropoff_datetime)

        start_time = time()
        df.to_sql(name=table_name, con=engine, if_exists='append')
        end_time = time()
        print("chuk inserted...took %.3f seconds." % (end_time - start_time))


def save_zone_data(url, engine, table_name):
    filename = download_csv(url)
    df = pd.read_csv(filename)

    # creating the database
    df.head(n=0).to_sql(name=table_name, con=engine, if_exists='replace')

    start_time = time()
    df.to_sql(name=table_name, con=engine, if_exists='append')
    end_time = time()

    print("chuk inserted...took {%.3f}" % (end_time - start_time))


def save_to_postgres(params):
    user = params.user
    password = params.password
    host = params.host
    port = int(params.port)
    db = params.db
    table_name = params.table_name
    zone_table = params.zone_table
    url = params.url
    zone_url = params.zone_url

    engine = create_engine(f'postgresql://{user}:{password}@{host}:{port}/{db}')

    save_trips_data(url, engine, table_name)
    save_zone_data(zone_url, engine, zone_table)


if __name__ == '__main__':
    parser = argparse.ArgumentParser(description="Ingest CSV data to postgres")

    parser.add_argument("--user", "-u", help="username for postgres")
    parser.add_argument("--password", help="password for postgres")
    parser.add_argument("--host", help="host for postgres")
    parser.add_argument("--port", help="port for postgres")
    parser.add_argument("--db", help="database for postgres")
    parser.add_argument("--table-name", help="output table name")
    parser.add_argument("--zone-table", help="zones table name")
    parser.add_argument("--url", help="url to csv file")
    parser.add_argument("--zone-url", help="url to zones csv file")

    args = parser.parse_args()

    save_to_postgres(args)


