# GM-TestFramework
Repository for GameMaker's Test Framework

This repository was created with the intent of presenting users with the internal test framework and also provide a way for the community to contribute with their own unit tests for detecting bugs.

This project is in GML and *should* work on all available exports.

> **Note**
> Running it from the command line, using `frameworkLauncher.py`, will only work for Enterprise users and will require extra configuration (see below)

---

## Usage
To create your own TestSuite using the framework, follow these steps:

1. Create a new constructor function that inherits TestSuite, as shown in the example below:

```js
function MyTestSuite() : TestSuite() constructor {
}
```

2. After creating the TestSuite, you need to register it. Inside the **Create Event** of `objRunner`, add your TestSuite:

```js
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

3. With the TestSuite registered, you can now start creating unit tests.

### Synchronous Tests

Synchronous tests are simple tests that can exist in two forms:

* Facts: These are regular synchronous tests executed with a single function call.
* Theories: These are data-driven synchronous tests expanded into multiple Facts at runtime.

Here's an example of how to create Facts and Theories using the TestFramework in GameMaker:

```js

function MyTestSuite() : TestSuite() constructor {

  // Notes:
  //    * The test result is automatically determined by the existence of failed assertions
  //    * A test can be forcibly ended using the test_end([_forcedResult]) function
  //    * When force ending a test, you can pass it a custom TestResult value (which will overwrite the automatic value)

  // This defines a synchronous unit test (the test will end as soon as the function ends)
  // Synchronous tests in the TestFramework are called 'Facts'
  addFact("a fact test description (unique name is recommended)", function() {

    // This is your test code!
    assert_equals(5, 5, "Two equal number literals should be equal!") // This assert will pass

  });
  
  // This defines a synchronous data-driven unit test (the test will end as soon as the function ends)
  // Data-driven synchronous tests in the TestFramework are called 'Theories'
  // Theories allow for creating manageable multiple input tests
  addTheory("a theory test description (unique name is recommended)", 
    [
      [ 1, 1, 2 ], // These will be the values of the first input
      [ 2, 2, 4 ], // These will be the values of the second input
      [ 3, 3, 6 ], // These will be the values of the third input
      [ 4, 4, 8 ], // There will be the values of the fourth input
    ],
    function(_arg1, _arg2, _result) {

      // This is your test code!
      assert_equals(_arg1 + _arg2, _result, "The sum failed") // This assert will pass for all inputs

      // NOTE: For each failed assert in a 'Theory', the input parameters will be included as part of the failed assertion data.
  });
}

```

### Asynchronous Tests

Asynchronous tests offer better control over the test's lifespan and are executed with the help of a mediator objTestAsync object (or an object inheriting from it). These mediator objects act as glue between the test and the object events and should inherit `objTestAsync`. The default `objTestAsync` object handles the following events:

- ev_create
- ev_step
- ev_cleanup

> **Note**
> If you require more events, create your own `objTestAsync<SubName>` object with the respective handlers (refer to existing `objTestAsyncSaveLoad` and `objTestAsyncNetworking`, stored inside `Modules/TestModule/Objects`).

Below is an example of how to create a TestAsync using the TestFramework in GameMaker:

```js

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

## Contributions

We welcome and appreciate contributions to the project, which can be made in two key areas:

* **Framework Modules**: You can contribute by improving or adding to the framework modules themselves, making them more powerful, versatile, and user-friendly.

* **Unit Tests**: Enhance the existing collection of unit tests by contributing new tests that cover different aspects of the GameMaker engine and ensure the reliability of the framework.

To contribute, please follow the standard Git workflow: fork the repository, make your changes, and submit a pull request. Be sure to test your changes thoroughly and provide clear documentation or comments as necessary. Your contributions will help make the framework more robust and valuable for the GameMaker community.
