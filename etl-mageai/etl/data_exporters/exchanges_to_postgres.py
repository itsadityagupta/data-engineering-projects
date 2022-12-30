from mage_ai.data_preparation.repo_manager import get_repo_path
from mage_ai.io.config import ConfigFileLoader
from mage_ai.io.postgres import Postgres
from pandas import DataFrame
from os import path

if 'data_exporter' not in globals():
    from mage_ai.data_preparation.decorators import data_exporter


@data_exporter
def export_data_to_postgres(df: DataFrame, **kwargs) -> None:
    """
    Template for exporting data to a PostgreSQL database.
    Specify your configuration settings in 'io_config.yaml'.

    Docs: https://github.com/mage-ai/mage-ai/blob/master/docs/blocks/data_loading.md#postgresql
    """
    schema_name = 'stocks'  # Specify the name of the schema to export data to
    table_name = 'exchanges'  # Specify the name of the table to export data to
    config_path = path.join(get_repo_path(), 'io_config.yaml')
    config_profile = 'default'

    with Postgres.with_config(ConfigFileLoader(config_path, config_profile)) as loader:
        for index, row in df.iterrows():
            query = f'''INSERT INTO {schema_name}.{table_name} (exchange_id, mic, operating_mic, name, participant_id, website_url, created_at, updated_at) 
            VALUES 
            ({row["exchange_id"]}, 
            '{row["mic"]}', 
            '{row["operating_mic"]}', 
            '{row["name"]}', 
            '{row["participant_id"]}', 
            '{row["website_url"]}', 
            '{row["created_at"]}', 
            '{row["updated_at"]}')'''
            loader.execute(query)
            loader.commit()
