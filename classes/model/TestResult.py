import xml.etree.ElementTree as ElementTree

from pydantic import BaseModel

from classes.utils.DataUtils import DataUtils


class TestResult(BaseModel):
    name: str = ""
    result: str = ""
    duration: float = 0.0
    assertions: int = 0
    exceptions: list[dict] = []
    errors: list[dict] = []

    def did_error(self):
        return len(self.exceptions) != 0

    def did_expire(self):
        return self.result == "Expired"

    def did_fail(self):
        return self.did_expire() or self.result == "Failed"
    
    def was_skipped(self):
        return self.result == "Skipped"
    
    def to_xml(self) -> ElementTree.Element:
        element = ElementTree.Element('testcase')
        element.set("name", self.name)
        element.set("assertions", str(self.assertions))
        element.set("duration", str(self.duration / 1000000))
        
        for exception in self.exceptions:
            exception_element = ElementTree.Element('error')
            exception_element.set("type", "ExceptionThrownError")
            exception_element.text = DataUtils.json_stringify(exception)
            element.append(exception_element)
            
        for error in self.errors:
            error_element = ElementTree.Element('failure')
            error_element.set("type", "AssertionError")
            error_element.text = DataUtils.json_stringify(error)
            element.append(error_element)
        
        if self.did_expire():
            error_element = ElementTree.Element('failure')
            error_element.set("type", "ExpiredError")
            element.append(error_element)

        if self.was_skipped():
            skipped_element = ElementTree.Element('skipped')
            element.append(skipped_element)


        return element