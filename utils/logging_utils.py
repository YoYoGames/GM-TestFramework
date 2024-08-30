import logging

LOGGING_LEVEL = logging.INFO

# Create a module-level logger
LOGGER = logging.getLogger('xunit_logger')

def config_logger(level=LOGGING_LEVEL, format='%(asctime)s [%(levelname)s]: %(message)s'):
    """
    Configures the static logger instance with the specified log level and format.
    
    Args:
        level (int): The log level. Defaults to LOGGER.INFO.
        format (str): The log message format. Defaults to a basic format with timestamp and level.
    """

    # Constants
    REDACTED_WORDS = ['-ak=', 'accessKey']
    REDACTED_MESSAGE = "<redacted to prevent exposure of sensitive data>"
    TIMESTAMP_FORMAT = '%Y-%m-%d %H:%M:%S'

    # Remove all handlers associated with the logger (if any)
    for handler in LOGGER.handlers[:]:
        LOGGER.removeHandler(handler)

    class MaskSensitiveInfoFilter(logging.Filter):
        def filter(self, record):
            # Check if the log record contains sensitive information
            if any(key in record.getMessage() for key in REDACTED_WORDS):
                # If it does, redact the sensitive information
                record.msg = REDACTED_MESSAGE
            return True

    # Create a console handler and add it to the logger
    console_handler = logging.StreamHandler()
    LOGGER.addHandler(console_handler)

    # Set the log level
    LOGGER.setLevel(level)

    # Apply settings
    formatter = logging.Formatter(format, TIMESTAMP_FORMAT)
    console_handler.setFormatter(formatter)

    # Add the filter to the console handler
    console_handler.addFilter(MaskSensitiveInfoFilter())