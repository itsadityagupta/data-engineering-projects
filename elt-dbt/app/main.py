from argparse import ArgumentParser

import app_config
import app_constants
from data_analysis import DataAnalysis
from load_to_postgres import LoadData

ap = ArgumentParser(add_help=False)
ap.add_argument(
    "-h",
    "--hardreload",
    help="Reload and clean the data",
    choices=[True, False],
    default=False,
    type=bool,
)
args = vars(ap.parse_args())

if args["hardreload"]:
    processed_data = DataAnalysis(app_config.input_file)
    processed_data.drop_columns(app_constants.unnecessary_columns)
    processed_data.describe()
    processed_data.save(app_config.output_file)

load_data = LoadData(
    app_config.postgres_hostname,
    app_config.postgres_dbname,
    app_config.postgres_username,
    app_config.postgres_password,
    app_config.postgres_port,
)
load_data.load_data_to_postgres(
    app_config.population_table,
    app_config.population_file,
    app_config.customer_table,
    app_config.output_file,
)
