from typing import Optional
import xml.etree.ElementTree as ElementTree

from pydantic import BaseModel

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
    
    def to_xml(self, classname: str = "") -> ElementTree.Element:
        element = ElementTree.Element('testcase')
        element.set("name", self.name)
        element.set("classname", classname if classname else self.name)

        element.set("time", str(self.duration / 1000000))
        element.set("status", "run")

        for exception in self.exceptions:
            exception_element = ElementTree.Element('error')
            exception_element.set("type", "ExceptionThrownError")

            # Format exception as human-readable text
            if isinstance(exception, dict):
                lines = []

                if exception.get('message'):
                    lines.append(f"Message: {exception['message']}")

                if exception.get('description'):
                    lines.append(f"Description: {exception['description']}")

                if exception.get('stack'):
                    lines.append("Callstack:")
                    stack_lines = exception['stack'].strip().split('\n')
                    for stack_line in stack_lines:
                        if stack_line.strip():
                            lines.append(f"  {stack_line.strip()}")

                exception_element.text = '\n'.join(lines) if lines else str(exception)
            else:
                exception_element.text = str(exception)

            element.append(exception_element)

        for error in self.errors:
            error_element = ElementTree.Element('failure')
            error_element.set("type", "AssertionError")

            # Create a human-friendly formatted message
            if isinstance(error, dict):
                lines = []

                if error.get('title'):
                    lines.append(f"Title: {error['title']}")

                if error.get('description'):
                    lines.append(f"Description: {error['description']}")

                if error.get('expected') is not None:
                    lines.append(f"Expected value: {error['expected']}")

                if error.get('actual') is not None:
                    lines.append(f"Got value: {error['actual']}")

                if error.get('message'):
                    lines.append(error['message'])

                if error.get('stack'):
                    lines.append("Callstack:")
                    # Split stack trace by newlines and format each line with indentation
                    stack_lines = error['stack'].strip().split('\n')
                    for stack_line in stack_lines:
                        if stack_line.strip():
                            lines.append(f"  {stack_line.strip()}")

                error_element.text = '\n'.join(lines) if lines else "Assertion failed"
            else:
                error_element.text = str(error)

            element.append(error_element)

        if self.did_expire():
            error_element = ElementTree.Element('failure')
            error_element.set("type", "ExpiredError")
            error_element.text = "Test execution expired"
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