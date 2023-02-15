from pathlib import Path
import pandas as pd
from prefect import flow, task
from prefect_gcp.cloud_storage import GcsBucket
from random import randint
from prefect.tasks import task_input_hash
from datetime import timedelta


@task(retries=3, cache_key_fn=task_input_hash, cache_expiration=timedelta(days=1))
def fetch(dataset_url: str) -> pd.DataFrame:
    """Read taxi data from web into pandas DataFrame"""
    df = pd.read_csv(dataset_url)
    return df


@task(log_prints=True)
def clean(df: pd.DataFrame, color: str) -> pd.DataFrame:
    """Fix dtype issues"""

    if color == "yellow":
        df["tpep_pickup_datetime"] = pd.to_datetime(df["tpep_pickup_datetime"])
        df["tpep_dropoff_datetime"] = pd.to_datetime(df["tpep_dropoff_datetime"])
    else:
        df["lpep_pickup_datetime"] = pd.to_datetime(df["lpep_pickup_datetime"])
        df["lpep_dropoff_datetime"] = pd.to_datetime(df["lpep_dropoff_datetime"])
        df['trip_type'] = df['trip_type'].astype('Int64')

    # added these transformations to have consistent data type across all the parquet files
    df["VendorID"] = df["VendorID"].astype('Int64')
    df['RatecodeID'] = df['RatecodeID'].astype('Int64')
    df["payment_type"] = df["payment_type"].astype('Int64')
    df['passenger_count'] = df["passenger_count"].astype('Int64')
    df['PULocationID'] = df['PULocationID'].astype('Int64')
    df["DOLocationID"] = df['DOLocationID'].astype('Int64')

    print(df.head(2))
    print(f"columns: {df.dtypes}")
    print(f"rows: {len(df)}")
    return df


@task()
def write_local(df: pd.DataFrame, color: str, dataset_file: str):
    """Write DataFrame out locally as parquet file"""
    path = f"data/{color}/{dataset_file}.parquet"
    df.to_parquet(path, compression="gzip")
    return path


@task()
def write_gcs(path: str) -> None:
    """Upload local parquet file to GCS"""
    gcs_block = GcsBucket.load("gcs-bucket")
    gcs_block.upload_from_path(from_path=path, to_path=path)
    return


@flow()
def etl_web_to_gcs(year: int, month: int, color: str) -> None:
    """The main ETL function"""
    dataset_file = f"{color}_tripdata_{year}-{month:02}"
    dataset_url = f"https://github.com/DataTalksClub/nyc-tlc-data/releases/download/{color}/{dataset_file}.csv.gz"

    df = fetch(dataset_url)
    df_clean = clean(df, color)
    path = write_local(df_clean, color, dataset_file)
    write_gcs(path)


@flow()
def etl_parent_flow(
    months: list[int] = [1, 2], years: list[int] = [2021], colors: list[str] = ["yellow"]
):
    for color in colors:
        for year in years:
            for month in months:
                etl_web_to_gcs(year, month, color)


if __name__ == "__main__":
    color = ["yellow"]
    months = [1, 2, 3]
    year = [2021]
    etl_parent_flow(months, year, color)
