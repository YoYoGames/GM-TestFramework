import logging

class LoggingUtils:

    LOGGING_LEVEL = logging.DEBUG

    @staticmethod
    def config_logger(level = LOGGING_LEVEL, format=f'%(asctime)s [%(levelname)s]: %(message)s'):

        # Constants
        REDACTED_WORDS = ['-ak=', 'accessKey']
        REDACTED_MESSAGE = "<redacted to prevent exposure of sensitive data>"
        TIMESTAMP_FORMAT = f'%Y-%m-%d %H:%M:%S'

        # Remove all handlers associated with the root logger object.
        for handler in logging.root.handlers[:]:
            logging.root.removeHandler(handler)

        class MaskSensitiveInfoFilter(logging.Filter):
            def filter(self, record):
                # Check if the log record contains sensitive information
                if any(key in record.getMessage() for key in REDACTED_WORDS):
                    # If it does, redact the password
                    record.msg = record.msg.replace(record.getMessage(), REDACTED_MESSAGE)
                return True

        # Create a console handler and add it to the root logger
        console_handler = logging.StreamHandler()
        logging.getLogger().addHandler(console_handler)

        # Set the log level
        logging.getLogger().setLevel(level)

        # Apply settings
        formatter = logging.Formatter(format, TIMESTAMP_FORMAT)
        console_handler.setFormatter(formatter)

        # Add the filter to the console handler
        console_handler.addFilter(MaskSensitiveInfoFilter())