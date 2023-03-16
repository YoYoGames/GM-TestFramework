# GM-TestFramework
Repository for GameMaker's Test Framework

This repository was created with the intent of presenting users with the internal test framework and also provide a way for the community to contribute with their own unit tests for detecting bugs.

This project is in GML and *should* work on all available exports.

*NOTE: As of this moment the test framework is being fully integrated on our pipeline and ran only on Windows for both VM and YYC.*

---

# Usage

In order to create your own TestSuite on the framework you should follow this workflow:

1. Create a new constructor function that inherits TestSuite, following the example below:

```gml

function MyTestSuite() : TestSuite() constructor {
}

```

2. After the TestSuite is create it won't run right away you need to register it, for that go inside the `Create Event` of `objRunner` and add register your TestSuite there:

```gml

// ################# TEST SUITE REGISTRATION #################

// Register test suites here...
testFramework.addSuite(BasicArrayTestSuite); 
testFramework.addSuite(BasicBufferTestSuite);
testFramework.addSuite(BasicDataStructuresGridTestSuite);
testFramework.addSuite(BasicDataStructuresListTestSuite);
// ....

testFramework.addSuite(MyTestSuite); // This is our test suite.

// ###########################################################

```

3. We are now set to go and can start creating unit tests.


## Synchronous Tests

These are the most simple types of tests and can exist in two different flavours:

* Facts: These correspond to normal sync tests that will execute with a single function call
* Theories: These correspond to data driven sync test and will be 'expanded' into multiple Facts at runtime.

Below is an example of how to create both Facts and Theories using GameMaker's TestFramework.

```gml

function MyTestSuite() : TestSuite() constructor {

  // Notes:
  //    * The test result is automatically determined by the existance of failed assertions
  //    * A test can be forcely ended using test_end([_forcedResult]) function
  //    * When force ending a test you can pass it a custom TestResult value (will overwrite the automatic value)
  
  // This defines a synchronous unit test (the test will end as soon as function ends)
  // Synchronous test in the TestFramework are called 'Facts'
  addFact("a fact test description (unique name is recommended)", function() {

    // This is your test code!
    assert_equals(5, 5, "Two equal number literals should be equal!") // This assert will pass

  });
  
  
  // This defined a synchronous data driven unit test (the test will end as soon as function ends)
  // Data driven synchronous tests in the TestFramework are called 'Theories'
  // Theories allow for creating manageable mutiple input tests
  addTheory("a theory test description (unique name is recommended)", 
    [
      [ 1, 1, 2 ], // These will be the values of the first input
      [ 2, 2, 4 ], // These will be the values of the second input
      [ 3, 3, 6 ], // These will be the values of the third input
      [ 4, 4, 8 ], // There will be the values of the forth input
    ]
    function(_arg1, _arg2, _result) {

      // This is your test code!
      assert_equals(_arg1 + _arg2, _result, "The sum failed") // This assert will pass for all inputs

      // NOTE: For each failed asssert in a 'Theory' the input parameters will be included as part as the failed assertion data.
  });
  
  
}

```

## Ascynchronous Tests

These are more complex tests that will allow for better control over the life-span of your test:

* TestAsync: These tests are executed with the help of a mediator 'objTestAsync' object (or an object inheriting from it).

Mediator TestAsync objects are responsible for serve as glue between the test and the events of an object and should inherit `objTestAsync`.
The default 'objTestAsync' object handles the following events:
  - ev_create
  - ev_step
  - ev_cleanup
If more events are required you should create your own `objTestAsync<SubName>` object with the respective handles (check existing `objTestAsyncSaveLoad` and `objTestAsyncNetworking`, stored inside `Modules/TestModule/Objects`)

Below is an example of how to create a TestAsync using GameMaker's TestFramework.

```gml

function MyTestSuite() : TestSuite() constructor {

  // ...
  
  // This defines an asynchronous unit test (the test will end as soon as function ends)
  // NOTES:
  //    * Async tests need to be ended manually by calling the test_end([_forcedResult]) function
  //    * The test result is automatically determined by the existance of failed assertions
  //    * When ending a test you can pass it a custom TestResult value (will overwrite the automatic value)
  //    * The test 'addTestAsync' function requires a mediator object (ex.: objTestAsync)
  //    * The test 'addTestAsync' function requires a struct of event-function pairs.
  addTestAsync("an async test description (unique name is recommended)", objTestAsync, {
  
    ev_create: function() {
      oldRoom = room;
      room_goto(rm_test1);
    },

    ev_step: function() {
      assert_equals(room, rm_test1, "The room should have changed");
      test_end(); // This will end the test, destroy the test instance and automatically call 'ev_cleanup' function.
    },
    
    ev_cleanup: function() {
      room_goto(oldRoom);
    }
  
  });
  
```

# Contributions



