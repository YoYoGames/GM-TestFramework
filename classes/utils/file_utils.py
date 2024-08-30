
import os
from pathlib import Path
import shutil

from classes.utils import data_utils
from classes.utils.logging_utils import LOGGER

def copy_file(src: Path, dst: Path):
    try:
        LOGGER.info(f'Copying file from {src} to {dst}')
        shutil.copy2(src, dst)
        LOGGER.info(f'File copied successfully')
    except Exception as e:
        LOGGER.error(f'An error occurred while copying the file: {e}')
    
    return dst

def copy_folder(src: Path, dest: Path, contents_only: bool = False):
    if not src.exists():
        LOGGER.error(f"Source folder '{src}' does not exist or is not accessible.")
        return None

    if not src.is_dir():
        LOGGER.error(f"Source '{src}' is not a folder.")
        return None

    # Make sure the destination folder exists
    os.makedirs(dest, exist_ok=True)

    try:
        if contents_only:
            # Copy only the contents of the source folder
            for item in os.listdir(src):
                item_path = src / item
                if item_path.is_dir():
                    shutil.copytree(item_path, dest / item, dirs_exist_ok=True)
                else:
                    shutil.copy2(item_path, dest)
        else:
            # Copy the folder and its content
            shutil.copytree(src, dest / src.name, dirs_exist_ok=True)

        LOGGER.info(f"Copied {'contents of' if contents_only else 'folder'} '{src}' to '{dest}'.")
    except Exception as e:
        LOGGER.error(f"Failed to copy {'contents of' if contents_only else 'folder'} '{src}' to '{dest}': {e}")
    
    return Path(dest)

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
        LOGGER.error('Cannot save: The data is None')
        return

    LOGGER.info(f'Saving data to {file_path}')
    try:
        with open(file_path, mode) as f:
            f.write(data)
        LOGGER.info(f'Data saved successfully to {file_path}')
    except Exception as e:
        LOGGER.error(f'Error while saving data to {file_path}: {e}')

def read_from_file(file_path: Path, mode='r') -> str:
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
        LOGGER.info(f'Data read successfully from {file_path}')
        return data
    except Exception as e:
        LOGGER.error(f'Error while reading data from {file_path}: {e}')
        return None

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
    json_str = data_utils.json_stringify(obj)
    
    # Save the JSON string to the specified file
    save_to_file(json_str, file_path)

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
    json_str = read_from_file(file_path, mode='r')
    if json_str is None:
        return None
    
    # Parse the JSON string into a Python object
    return data_utils.json_parse(json_str)
    
def clean_directory(directory_path: Path):
    """
    Removes all files and subdirectories in the specified directory.

    Args:
        directory_path (str or Path): The path to the directory to clean.
    """
    for filename in os.listdir(directory_path):
        file_path = os.path.join(directory_path, filename)
        try:
            if os.path.isfile(file_path) or os.path.islink(file_path):
                os.unlink(file_path)  # remove the file
            elif os.path.isdir(file_path):
                shutil.rmtree(file_path)  # remove the directory
        except Exception as e:
            LOGGER.error(f'Failed to delete {file_path}. Reason: {e}')