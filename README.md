# GM-TestFramework
Repository for GameMaker's Test Framework

This repository was established to showcase the internal test framework to users and to offer a platform for the community to contribute their own unit tests for identifying bugs, as well as to improve the framework itself.

---

## Usage

This project is written in pure GML and *should* work on all available exports.

### From the IDE

> **Note**
> When running the project from the IDE, there are limitations on tests that require external servers to function. These servers are initilaized and managed by the command line launcher, and you'll need to initialize them manually when running the project within the IDE.

To utilize the project within the IDE, simply select the desired platform and press the 'Run' button.

</br>

### From the Command Line

> **Warning**
> The command line framework launcher tool is only compatible with Windows OS and is available exclusively for Enterprise users and requires additional configuration.

To run the launcher from the command line, you need to have Python and Node.js installed. Then, follow these steps:

1. Set an environment variable named `GM_ACCESS_KEY` with the value set to your [Access Key](https://gamemaker.io/account/access_keys).
2. Run the `setup.bat` script, which will install all Python and Node.js dependencies.
3. Run `python frameworkLauncher.py` script with the following arguments:
    * `-p` followed by a space separated list of platforms to run tests on \[allows: windows mac linux android ios tvos html5\]
    * `-r` followed by a space separated list of runners \[allows: vm yyc\]
    * `-f` followed by the RSS feed to be used for retrieving the runtime (defaults to DEV)
    * `-v` followed by the version of the runtime to be tested (defaults to latest)

</br>

---

## Adding TestsSuites and Tests
To create your own TestSuite using the framework, follow these steps:

1. Create a new constructor function that inherits TestSuite, as shown in the example below:

```js
function MyTestSuite() : TestSuite() constructor {
}
```
</br>

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
</br>

3. With the TestSuite registered, you can now start creating unit tests.

</br>

### Synchronous Tests

Synchronous tests are simple tests that can exist in two forms:

* **Facts**: These are regular synchronous tests executed with a single function call.
* **Theories**: These are data-driven synchronous tests expanded into multiple Facts at runtime.

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

</br>

### Asynchronous Tests

Asynchronous tests offer better control over the test's lifespan and are executed with the help of a mediator objTestAsync object (or an object inheriting from it). These mediator objects act as glue between the test and the object events and should inherit `objTestAsync`. The default `objTestAsync` object handles the following events:

- ev_create
- ev_step
- ev_cleanup

</br>

> **Note**
> If you require more events, create your own `objTestAsync<SubName>` object with the respective handlers (refer to existing `objTestAsyncSaveLoad` and `objTestAsyncNetworking`, stored inside `Modules/TestModule/Objects`).

</br>

Below is an example of how to create a TestAsync using the TestFramework in GameMaker:

```js

function MyTestSuite() : TestSuite() constructor {

  // ...
  
  // This defines an asynchronous unit test (the test will only end when 'test_end()' is explicitly called)
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

</br>

---

## Contributions

We welcome and appreciate contributions to the project, which can be made in two key areas:

* **Framework Modules**: You can contribute by improving or adding to the framework modules themselves, making them more powerful, versatile, and user-friendly.

* **Unit Tests**: Enhance the existing collection of unit tests by contributing new tests that cover different aspects of the GameMaker engine and ensure the reliability of the framework.

To contribute, please follow the standard Git workflow: fork the repository, make your changes, and submit a pull request. Be sure to test your changes thoroughly and provide clear documentation or comments as necessary. Your contributions will help make the framework more robust and valuable for the GameMaker community.
