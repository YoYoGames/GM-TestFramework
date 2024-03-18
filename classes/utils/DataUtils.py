import json
import logging


class DataUtils:
    @staticmethod
    def json_stringify(obj):
        """
        Converts an object to a JSON string.

        Args:
            obj: The object to convert to JSON.

        Returns:
            A JSON string representation of the object or None if an error occurs.
        """
        try:
            return json.dumps(obj, indent=4)
        except (TypeError, ValueError) as e:
            logging.error(f'Error while converting object to JSON string: {e}')
            return None

    @staticmethod
    def json_parse(json_str):
        """
        Parses a JSON string and returns the corresponding Python object.

        Args:
            json_str: The JSON string to parse.

        Returns:
            A Python object represented by the JSON string, or None if an error occurs.
        """
        try:
            return json.loads(json_str)
        except (json.JSONDecodeError, TypeError) as e:
            logging.error(f'Error while parsing JSON string: {e}')
            return None