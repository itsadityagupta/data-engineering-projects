from pathlib import Path
import pandas as pd
from prefect import flow, task
from prefect_gcp.cloud_storage import GcsBucket
from prefect_gcp import GcpCredentials
from prefect.tasks import task_input_hash
from datetime import timedelta


@task(retries=3, cache_key_fn=task_input_hash, cache_expiration=timedelta(days=1))
def extract_from_gcs(color: str, year: int, month: int) -> Path:
    """Download trip data from GCS"""
    gcs_path = f"data/{color}/{color}_tripdata_{year}-{month:02}.parquet"
    gcs_block = GcsBucket.load("gcs-bucket")
    gcs_block.get_directory(from_path=gcs_path, local_path=f"data/")
    return Path(f"data/{gcs_path}")


@task()
def write_bq(path: Path, color: str) -> int:
    """Write DataFrame to BiqQuery"""

    df = pd.read_parquet(path)
    gcp_credentials_block = GcpCredentials.load("gcp-block")

    df.to_gbq(
        destination_table=f"dezoomcamp.rides-{color}",
        project_id="dtc-de-zoomcamp-2023",
        credentials=gcp_credentials_block.get_credentials_from_service_account(),
        chunksize=500_000,
        if_exists="append",
    )

    return df.shape[0]


@flow()
def etl_gcs_to_bq(year: int, month: int, color: str):
    """Main ETL flow to load data into Big Query"""
    path = extract_from_gcs(color, year, month)
    return write_bq(path, color)


@flow(log_prints=True)
def gcs_to_bq_parent_flow(
        months: list[int] = [1, 2], year: int = 2020, color: str = "yellow"
):
    total_records = 0
    for month in months:
        total_records += etl_gcs_to_bq(year, month, color)

    print(f"{total_records} records processed.")


if __name__ == "__main__":
    gcs_to_bq_parent_flow(months=[2], year=2019, color="yellow")
