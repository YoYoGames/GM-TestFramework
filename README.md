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
> The command line framework launcher tool is only compatible with Windows OS and is available exclusively for Enterprise users. You'll need to obtain an **Access Key** from the [following link](https://gamemaker.io/account/access_keys).

To run the launcher from the command line, you need to have Python and Node.js installed. Then, follow these steps:

1. Run the `setup.bat` script, which will install all Python and Node.js dependencies.
2. Run `python framework_launcher.py` script with the following arguments:
   * `-cf` followed by the path to the configuration file. With the following format:

```json
{
    "Launcher.accessKey": null,
    "Launcher.userFolder": null,
    "Launcher.runtimeVersion": null,

    "Launcher.runners": "vm",
    "Launcher.targets": "windows|Local",
    "Launcher.feed": "https://gms.yoyogames.com/Zeus-Runtime-Nocturnus-I.rss",
    "Launcher.project": "projects\\xUnit\\xUnit.yyp",

    "Launcher.html5Runner": null,

    "Logger.level": 10,
    
    "HttpPublisher.port": 8080,
    "HttpPublisher.endpoint": "tests"
}
```

   * `-ak` followed by your **Access Key**
   * `-uf` followed by the a GameMaker's user folder path (ex: `C:\Users\<User>\AppData\Roaming\GameMakerStudio2\<username>`)
   * `-t` followed by a comma separated list of platform|device pairs (valid platforms: `[windows mac linux android ios tvos HTML5]`)
   * `-r` followed by a comma separated list of runners (valid runners: `[vm yyc]`)
   * `-f` followed by the RSS feed to be used for retrieving the runtime (defaults to DEV)
   * `-rv` followed by the version of the runtime to be tested (defaults to latest)
   * `-h5r` followed by the path to the HTML5 scripts folder (defaults to selected runtime)

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

## Test and TestSuite options

To apply specific options to a test, test suite, or the entire framework run, it is necessary to provide the relevant configuration during the creation of each entity.

When configuring options for a test, the configuration should be provided during its creation. On the other hand, for test suites, the configuration must be provided within the constructor body of the given test suite.

Examples of these configurations are shown below:

```js

function MyTestSuite() : TestSuite() constructor {

   addFact("a fact test description (unique name is recommended)", function() {

      // This is your test code!
      assert_equals(5, 5, "Two equal number literals should be equal!") // This assert will pass

   }, {

      // NOTES:
      //    * These options will be applied to the current test.
      //    * These options will overwrite any of the defaults being applied.
      //    * The 'test_filter' expects a predicate function that will filter execution (there are are already some 'platform_*' functions to help on that)
      //    * The 'test_timeout_millis' is used mostly for async tests and will terminate the test after the given amount of time with an 'expired' result
      test_filter: platform_desktop,
      test_timeout_millis: 1000,
   });


   // NOTES
   //    * These options will be applied to the current suite.
   //    * These options will overwrite any of the defaults being applied.
   //    * The 'suite_filter' expects a predicate function that will filter execution (there are are already some 'platform_*' functions to help on that)
   //    * The 'suite_timeout_millis' will terminate the suite after the given amount of time with an 'expired' result
   //    * The 'suite_bail_on_fail' will bail out of suite execution upon the first failed test
   //    * The 'suite_delay_seconds' will allow for a time gap between tests inside the test suite.
   config({
      suite_filter: platform_desktop,
      suite_timeout_millis: 1000,
      suite_bail_on_fail: true,
      suite_delay_seconds: 0.100
   })

}

```


</br>

---

## Configuring the TestFramework (ADVANCED)

You can configura advanced functionality of the test framework by looking at the `frameworkSetup` script. This script is used to define default configurations used by the various classes (constructors) in the various modules.
These are the properties that can be configured using the `config_set` function (part of the configuration manager).

### Test Properties

The `Test` constructor allows these default properties:

- **`test_end_hook`** {_Function_} Hook function that will be executed at the end of the test.
- **`test_start_hook`** {_Function_} Hook function that will be executed at the start of the test.
- **`test_filter`** {_Function_} Predicate function that determines whether the test should run or not.
- **`test_timeout_millis`** {_Function_} The number of millis to wait until the test timesout.

### TestSuite Properties

The `TestSuite` constructor allows these default properties:

- **`suite_end_hook`** {_Function_} Hook function that will be executed at the end of the suite.
- **`suite_start_hook`** {_Function_} Hook function that will be executed at the start of the suite.
- **`suite_filter`** {_Function_} Predicate function that determines whether the suite should run or not.
- **`suite_timeout_millis`** {_Function_} The number of millis to wait until the suite timesout.
- **`suite_bail_on_fail`** {_Bool_} Should the suite bail execution after the first failed suite.
- **`suite_delay_seconds`** {_Real_} The number of seconds to wait between tests.

### TestFramework Properties

The `TestFramework` constructor allows these default properties:

- **`framework_end_hook`** {_Function_} Hook function that will be executed at the end of the framework.
- **`framework_start_hook`** {_Function_} Hook function that will be executed at the start of the framework.
- **`framework_filter`** {_Function_} Predicate function that determines whether the framework should run or not.
- **`framework_timeout_millis`** {_Function_} The number of millis to wait until the framework timesout.
- **`framework_bail_on_fail`** {_Bool_} Should the suite bail execution after the first failed framework.
- **`framework_delay_seconds`** {_Real_} The number of seconds to wait between suites.

### Assert Properties

The `Assert` constructor allows these default properties:

- **`assert_failed_hook`** {_Function_} Hook function that will be executed on every failed assertion.
- **`assert_passed_hook`** {_Function_} Hook function that will be executed on every passed assertion.
- **`assert_stack_base_depth`** {_Real_} The value used to specify the base depth for the stack (number of function calls from the `assert` call until the `debug_get_callstack` call) 
- **`assert_stack_depth`** {_Real_} The number of stack entries to show in the assert information.

### Logger Properties

The `Logger` constructor allows these default properties:

- **`logger_level`** {_Real_} The filter level for showing log messages (levels below this value are not shown, see `LoggerLevel` enum)
- **`logger_time_format`** {_String_} The format used for the time display. Allows `{Y}` (year), `{m}` (month), `{d}` (day), `{H}` (hours), `{M}` (minutes) and `{S}` (seconds).
- **`logger_message_format`** {_String_} The format used for the log message. Allows `{message}` (the actual message), `{time}` (displays the time) and `{level}` (string representation of the level).

</br>

> **Note**
> You can also use a `config.json` file to pass all the above configurations (this is used by the framework launcher tool).

</br>

> **Warning**
> Function callbacks and delegates cannot be defined inside the external `config-json` file.

</br>

---

## Contributions

We welcome and appreciate contributions to the project, which can be made in two key areas:

* **Framework Modules**: You can contribute by improving or adding to the framework modules themselves, making them more powerful, versatile, and user-friendly.

* **Unit Tests**: Enhance the existing collection of unit tests by contributing new tests that cover different aspects of the GameMaker engine and ensure the reliability of the framework.

To contribute, please follow the standard Git workflow: fork the repository, make your changes, and submit a pull request. Be sure to test your changes thoroughly and provide clear documentation or comments as necessary. Your contributions will help make the framework more robust and valuable for the GameMaker community.
