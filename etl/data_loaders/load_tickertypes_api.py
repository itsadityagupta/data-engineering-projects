import io
import pandas as pd
import requests
from polygon_key import POLYGON_KEY
from pandas import DataFrame

if 'data_loader' not in globals():
    from mage_ai.data_preparation.decorators import data_loader
if 'test' not in globals():
    from mage_ai.data_preparation.decorators import test


@data_loader
def load_data_from_api(**kwargs) -> DataFrame:
    """
    Fetches all the ticker types from Polygon API
    """
    url = f'https://api.polygon.io/v3/reference/tickers/types?asset_class=stocks&apiKey={POLYGON_KEY}'

    response = requests.get(url)
    results = response.json()["results"]
    return pd.DataFrame.from_records(results)


@test
def test_output(df) -> None:
    """
    Template code for testing the output of the block.
    """
    assert df is not None, 'The output is undefined'
