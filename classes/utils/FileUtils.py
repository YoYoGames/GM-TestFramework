import logging
from pathlib import Path

from classes.utils.DataUtils import DataUtils

class FileUtils:

    @staticmethod
    def save_to_file(data, file_path: Path, mode='w'):
        """
        Saves data to a specified file. By default, it assumes the data is a string ('w' mode).
        For binary data, use mode='wb'.
        
        Args:
            data: The data to save. Could be a string or bytes depending on the mode.
            file_path: The path of the file where the data will be saved.
            mode: The mode in which to open the file ('w' for text, 'wb' for binary).
        """
        if data is None:
            logging.error('Cannot save: The data is None')
            return

        logging.info(f'Saving data to {file_path}')
        try:
            with open(file_path, mode) as f:
                f.write(data)
            logging.info(f'Data saved successfully to {file_path}')
        except Exception as e:
            logging.error(f'Error while saving data to {file_path}: {e}')

    @staticmethod
    def read_from_file(file_path: Path, mode='r'):
        """
        Reads data from a specified file. By default, it assumes the data is a string ('r' mode).
        For binary data, use mode='rb'.
        
        Args:
            file_path: The path of the file from which the data will be read.
            mode: The mode in which to open the file ('r' for text, 'rb' for binary).
            
        Returns:
            The data read from the file, or None if an error occurs.
        """
        try:
            with open(file_path, mode, encoding='utf-8' if mode=='r' else None) as f:
                data = f.read()
            logging.info(f'Data read successfully from {file_path}')
            return data
        except Exception as e:
            logging.error(f'Error while reading data from {file_path}: {e}')
            return None

    @staticmethod
    def save_data_as_json(obj, file_path: Path):
        """
        Saves a Python object as JSON to a specified file.

        Args:
            obj: The Python object to be serialized to JSON and saved.
                This can be any JSON serializable object, such as a dictionary, list, string, number, or boolean.
            file_path: The path to the file where the JSON representation of the object will be saved.
                    This should be a Path object representing the file path.

        Returns:
            None
        """
        # Convert the object to a JSON string
        json_str = DataUtils.json_stringify(obj)
        
        # Save the JSON string to the specified file
        FileUtils.save_to_file(json_str, file_path)

    @staticmethod
    def read_data_from_json(file_path: Path):
        """
        Reads JSON data from a specified file and parses it into a Python object.

        Args:
            file_path: The path to the JSON file to be read.
                    This should be a Path object representing the file path.

        Returns:
            The Python object parsed from the JSON data in the file.
            If an error occurs during file reading or JSON parsing, None is returned.
        """
        # Read the JSON string from the file
        json_str = FileUtils.read_from_file(file_path, mode='r')
        if json_str is None:
            return None
        
        # Parse the JSON string into a Python object
        return DataUtils.json_parse(json_str)