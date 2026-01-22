from typing import Optional
import xml.etree.ElementTree as ElementTree

from pydantic import BaseModel

from utils import data_utils

class TestResult(BaseModel):
    name: str = ""
    result: str = ""
    duration: float = 0.0
    assertions: int = 0
    exceptions: Optional[list] = []
    errors: Optional[list[dict]] = []

    def did_error(self):
        return len(self.exceptions) != 0

    def did_expire(self):
        return self.result.lower() == "expired"

    def did_fail(self):
        return self.did_expire() or self.result.lower() == "failed"
    
    def was_skipped(self):
        return self.result.lower() == "skipped"
    
    def to_xml(self) -> ElementTree.Element:
        element = ElementTree.Element('testcase')
        element.set("name", self.name)

        # Extract classname from test name (part before first hyphen, if any)
        classname = self.name.split('-')[0] if '-' in self.name else self.name
        element.set("classname", classname)

        element.set("time", str(self.duration / 1000000))
        element.set("status", "run")

        for exception in self.exceptions:
            exception_element = ElementTree.Element('error')
            exception_element.set("type", "ExceptionThrownError")

            # Handle both string and dict exceptions
            if isinstance(exception, dict):
                exception_element.set("message", str(exception.get('message', 'Exception occurred')))
                exception_element.text = data_utils.json_stringify(exception)
            else:
                exception_element.set("message", str(exception))
                exception_element.text = str(exception)

            element.append(exception_element)

        for error in self.errors:
            error_element = ElementTree.Element('failure')
            error_element.set("type", "AssertionError")

            # Create a meaningful message from error details
            message_parts = []
            if isinstance(error, dict):
                if error.get('description'):
                    message_parts.append(error['description'])
                if error.get('expected') is not None and error.get('actual') is not None:
                    message_parts.append(f"Expected: {error['expected']}, Actual: {error['actual']}")
                error_element.set("message", ' - '.join(message_parts) if message_parts else "Assertion failed")
                error_element.text = data_utils.json_stringify(error)
            else:
                error_element.set("message", str(error))
                error_element.text = str(error)

            element.append(error_element)

        if self.did_expire():
            error_element = ElementTree.Element('failure')
            error_element.set("type", "ExpiredError")
            error_element.set("message", "Test execution expired")
            element.append(error_element)

        if self.was_skipped():
            skipped_element = ElementTree.Element('skipped')
            element.append(skipped_element)


        return element
    
    def to_dict(self) -> dict:
        return {
            'name': self.name,
            'result': self.result,
            'time': self.duration / 1000000,
            'assertions': self.assertions,
            'exceptions': self.exceptions,
            'errors': self.errors,
        }

    def to_summary(self) -> dict:
        summary = {
            'name': self.name,
            **({'errors': [
                    {
                        'expected': error.get('expected') if isinstance(error, dict) else None,
                        'actual': error.get('actual') if isinstance(error, dict) else str(error),
                        'description': error.get('description') if isinstance(error, dict) else None
                    } for error in self.errors
                ]} if self.errors else {})
        }

        if self.exceptions:
            summary['exceptions'] = {
                'count': len(self.exceptions),
                'first': self.exceptions[0]
            }

        return summary