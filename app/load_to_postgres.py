import csv

import psycopg2
from logger import logger
from shared import app_functions


class LoadData:
    """Connects to Postgres and loads data into it."""

    def __init__(self, host, database, username, password, port):
        self.conn = None
        self.host = host
        self.database = database
        self.username = username
        self.password = password
        self.port = port

    def create_db_connection(self):
        """Connects to the Postgres Instance"""

        if self.conn is not None:
            logger.warning(
                f"Already connected to Postgres...{self.conn.get_dsn_parameters}"
            )
        else:
            try:
                self.conn = psycopg2.connect(
                    host=self.host,
                    database=self.database,
                    user=self.username,
                    password=self.password,
                    port=self.port,
                )
                self.conn.autocommit = True
                logger.info(
                    f"Connected to Postgres...{self.conn.get_dsn_parameters()}"
                )

            except psycopg2.Error as err:
                logger.error(f"Can't connect to Postgres. {err}")
                raise err

    def load_population_data_to_postgres(
        self, population_table, population_file
    ):
        """Reads population data from the file and loads it to Postgres"""

        logger.info("Loading population data...")

        file_reader = open(population_file, mode="r")
        file = csv.reader(file_reader, delimiter=",")
        next(file, None)  # skip headers

        insert_query = app_functions.insert_population_data_query()
        with self.conn.cursor() as crs:
            for row in file:
                crs.execute(insert_query.format(population_table), row)

        file_reader.close()
        logger.info("Population data loaded to Postgres!")

    def load_customer_data_to_postgres(self, customer_table, customer_file):
        """Reads customer data from the file and loads it to Postgres"""

        logger.info("Loading customer data...")

        file_reader = open(customer_file, mode="r")
        file = csv.reader(file_reader, delimiter=",")
        next(file, None)  # skip headers

        insert_query = app_functions.insert_customer_data_query()
        with self.conn.cursor() as crs:
            for row in file:
                crs.execute(insert_query.format(customer_table), row)

        file_reader.close()
        logger.info("Customer details loaded to Postgres")

    def load_data_to_postgres(
        self, population_table, population_file, customer_table, customer_file
    ):
        """Loads population and customer data to Postgres"""

        logger.info("Connecting to Postgres...")

        self.create_db_connection()
        self.load_population_data_to_postgres(
            population_table, population_file
        )
        self.load_customer_data_to_postgres(customer_table, customer_file)

        logger.info("Data loaded to Postgres successfully!")
