import logging

logging.basicConfig(
    level=logging.INFO,
    filemode="w",
    format="%(asctime)s - %(filename)s.%(funcName)s - %(levelname)s - %(message)s",
)
logger = logging.getLogger("data_analysis_logger")
