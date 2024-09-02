import datetime
from typing import Optional
import xml.etree.ElementTree as ElementTree

from pydantic import BaseModel
from classes.model.TestResult import TestResult

class TestSuiteResult(BaseModel):
    name: str = ""
    timestamp: float = 0
    tests: Optional[list[TestResult]] = []

    def get_duration(self):
        return sum(test.duration for test in self.tests)

    def get_assertion_count(self):
        return sum(test.assertions for test in self.tests)

    def get_test_count(self):
        return len(self.tests)

    def get_error_count(self):
        return sum(1 for test in self.tests if test.did_error())

    def get_failure_count(self):
        return sum(1 for test in self.tests if test.did_fail())
    
    def get_skipped_count(self):
        return sum(1 for test in self.tests if test.was_skipped())

    def get_iso_timestamp(self):
        dt = datetime.datetime.fromtimestamp(self.timestamp)
        iso_format = dt.isoformat()
        return iso_format

    def to_xml(self, suffix: str = "") -> ElementTree.Element:
        element = ElementTree.Element('testsuite')
        element.set("name", f'{self.name}:{suffix}')
        element.set("tests", str(self.get_test_count()))
        element.set("failures", str(self.get_failure_count()))
        element.set("errors", str(self.get_error_count()))
        element.set("skipped", str(self.get_skipped_count()))
        element.set("assertions", str(self.get_assertion_count()))
        element.set("time", str(self.get_duration() / 1000000))
        element.set("timestamp", self.get_iso_timestamp())

        for test in self.tests:
            element.append(test.to_xml())
        return element
    
    def to_dict(self) -> dict:
        return {
            'name': self.name,
            'tallies': {    
                'tests': self.get_test_count(),
                'failures': self.get_failure_count(),
                'errors': self.get_error_count(),
                'skipped': self.get_skipped_count(),
                'assertions': self.get_assertion_count(),
            },
            'time': self.get_duration() / 1000000,
            'timestamp': self.timestamp,
            'timestamp_iso': self.get_iso_timestamp(),
            'tests': [ test.to_dict() for test in self.tests ]
        }