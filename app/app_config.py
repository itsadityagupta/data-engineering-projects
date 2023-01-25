import configparser

config = configparser.ConfigParser()
config.read("config/configuration.ini")

input_file = config["application"]["input-file"]
output_file = config["application"]["output-file"]
population_file = config["application"]["population-file"]

postgres_hostname = config["postgres-db"]["hostname"]
postgres_dbname = config["postgres-db"]["database"]
postgres_username = config["postgres-db"]["username"]
postgres_password = config["postgres-db"]["password"]
postgres_port = config["postgres-db"]["port"]
customer_table = config["postgres-db"]["customer-table"]
population_table = config["postgres-db"]["population-table"]
