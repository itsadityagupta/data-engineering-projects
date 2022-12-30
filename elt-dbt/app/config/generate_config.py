import configparser

config_file = configparser.ConfigParser()

# postgres connection details
config_file.add_section("postgres-db")
config_file.set("postgres-db", "hostname", "localhost")
config_file.set("postgres-db", "database", "churn")
config_file.set("postgres-db", "customer-table", "customer_details")
config_file.set("postgres-db", "population-table", "population")
config_file.set("postgres-db", "username", "aditya")
config_file.set("postgres-db", "password", "aditya1234")
config_file.set("postgres-db", "port", "5432")

# application configs
config_file.add_section("application")
config_file.set("application", "input-file", "data/telecom_customer_churn.csv")
config_file.set("application", "output-file", "data/processed_churn_data.csv")
config_file.set(
    "application", "population-file", "data/telecom_zipcode_population.csv"
)

# write configs to a file
with open(r"configuration.ini", "w") as conf_file_obj:
    config_file.write(conf_file_obj)
    conf_file_obj.flush()
