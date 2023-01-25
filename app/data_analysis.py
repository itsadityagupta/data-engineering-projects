import app_config
import app_constants
import pandas as pd
from logger import logger
from pandas import DataFrame

pd.set_option("display.max_rows", None)
pd.set_option("display.max_columns", None)
pd.set_option("display.width", None)
pd.set_option("display.max_colwidth", None)


class DataAnalysis:
    """Perform basic data cleaning"""

    def __init__(self, input_file: str) -> None:
        self.input_file: str = input_file
        self.churn_data: DataFrame = pd.read_csv(input_file)
        logger.info("Data read successfully!")

    def drop_columns(self, unnecessary_columns) -> None:
        """Drop unnecessary columns"""

        self.churn_data.drop(unnecessary_columns, axis=1, inplace=True)
        logger.info(f"columns dropped: {unnecessary_columns}")

    def describe(self) -> None:
        """Displays basic details about the data"""

        logger.info("Describing data...")
        logger.info(
            f"rows: {self.churn_data.shape[0]}, cols: {self.churn_data.shape[1]}"
        )
        logger.info(f"Columns: {self.churn_data.columns}")
        logger.info(self.churn_data.describe(include="all"))
        logger.info(self.churn_data.head())

    def save(self, output_file: str) -> None:
        """Saves the file to the given path"""

        self.churn_data.to_csv(output_file, index=False)
        logger.info(f"File saved to: {output_file}")
