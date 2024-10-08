
import datetime
from typing import Optional
from pydantic import BaseModel
import xml.etree.ElementTree as ElementTree

from classes.model.TestResult import TestResult
from classes.model.TestSuiteResult import TestSuiteResult

class TestFrameworkResult(BaseModel):
    name: str = ""
    timestamp: float = 0
    testsuites: Optional[list[TestSuiteResult]] = []

    def get_duration(self):
        return sum(testsuite.get_duration() for testsuite in self.testsuites)
    
    def get_assertion_count(self):
        return sum(testsuite.get_assertion_count() for testsuite in self.testsuites)

    def get_test_count(self):
        return sum(testsuite.get_test_count() for testsuite in self.testsuites)

    def get_error_count(self):
        return sum(testsuite.get_error_count() for testsuite in self.testsuites)

    def get_failure_count(self):
        return sum(testsuite.get_failure_count() for testsuite in self.testsuites)
    
    def get_skipped_count(self):
        return sum(testsuite.get_skipped_count() for testsuite in self.testsuites)

    def get_iso_timestamp(self):
        dt = datetime.datetime.fromtimestamp(self.timestamp)
        iso_format = dt.isoformat()
        return iso_format
        
    def get_failed_and_expired_tests(self):
        failed_tests: list[TestResult] = []
        expired_tests: list[TestResult] = []

        for suite in self.testsuites or []:
            for test in suite.tests or []:
                if test.result.lower() == 'failed':
                    failed_tests.append(test)
                elif test.result.lower() == 'expired':
                    expired_tests.append(test)

        return failed_tests, expired_tests

    def to_xml(self) -> ElementTree.Element:
        element = ElementTree.Element('testsuites')
        element.set("name", self.name)
        element.set("tests", str(self.get_test_count()))
        element.set("failures", str(self.get_failure_count()))
        element.set("errors", str(self.get_error_count()))
        element.set("skipped", str(self.get_skipped_count()))
        element.set("assertions", str(self.get_assertion_count()))
        element.set("time", str(self.get_duration() / 1000000))
        element.set("timestamp", self.get_iso_timestamp())

        for testsuite in self.testsuites:
            element.append(testsuite.to_xml(self.name))
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
            'testsuites': [ suite.to_dict() for suite in self.testsuites ]
        }
    
    def to_summary(self) -> dict:

        failed_tests, expired_tests = self.get_failed_and_expired_tests()

        return {
            'tallies': {    
                'failures': self.get_failure_count(),
                'skipped': self.get_skipped_count(),
                'passed': self.get_test_count() - self.get_failure_count() - self.get_skipped_count(),
            },
            'status': 'failed' if self.get_failure_count() else 'passed',
            'details': {
                'failed': [ test.to_summary() for test in failed_tests ],
                'expired': [ test.to_summary() for test in expired_tests ],
            }
        }