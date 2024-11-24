import logging
from logging.handlers import RotatingFileHandler
import uuid
import os

def setup_logger():
    # Ensuring the directory for logs exists
    if not os.path.exists('logs'):
        os.makedirs('logs')

    # Create logger
    logger = logging.getLogger('RelationalDataFlowLogger')
    logger.setLevel(logging.INFO)  # Adjust as needed

    # Create formatter
    formatter = logging.Formatter('%(asctime)s - %(name)s - %(levelname)s - %(message)s - execution_id=%(execution_id)s')

    # Create and configure handlers
    file_handler = RotatingFileHandler('logs/logs_relational_data_pipeline.txt', maxBytes=10000, backupCount=5)
    file_handler.setLevel(logging.INFO)
    file_handler.setFormatter(formatter)

    # Add handlers to the logger
    logger.addHandler(file_handler)

    return logger

def log_message(logger, level, msg):
    extra = {'execution_id': str(uuid.uuid4())}  # Generating a new UUID for each log entry
    if level.lower() == 'info':
        logger.info(msg, extra=extra)
    elif level.lower() == 'error':
        logger.error(msg, extra=extra)
    elif level.lower() == 'warning':
        logger.warning(msg, extra=extra)
    elif level.lower() == 'debug':
        logger.debug(msg, extra=extra)