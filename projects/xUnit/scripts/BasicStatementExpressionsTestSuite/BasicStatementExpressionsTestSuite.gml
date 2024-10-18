

function BasicStatementExpressionsTestSuite() : TestSuite() constructor {
	
	//if any of these are broken something is really wrong internally
	
	#region if/else statements
	
    // Test for constant true condition in If statement
    addFact("If statement constant true", function() {
        var result = 0;

        if (true) {
            result = 1;
        } else {
            assert_true(false, "Should not reach else block in constant true test.");
        }

        // Assertions
        assert_equals(result, 1, "If statement constant true failed.");
    });

    // Test for constant false condition in If statement
    addFact("If statement constant false", function() {
        var result = 0;

        if (false) {
            assert_true(false, "Should not reach if block in constant false test.");
        } else {
            result = 1;
        }

        // Assertions
        assert_equals(result, 1, "If statement constant false failed.");
    });

    // Test for dynamic condition in If statement
    addFact("If statement dynamic true", function() {
        var result = 0;
        var condition = true;

        if (condition) {
            result = 1;
        } else {
            assert_true(false, "Should not reach else block in dynamic condition test.");
        }

        // Assertions
        assert_equals(result, 1, "If statement dynamic condition failed.");
    });

    // Test for dynamic false condition in If statement
    addFact("If statement dynamic false", function() {
        var result = 0;
        var condition = false;

        if (condition) {
            assert_true(false, "Should not reach if block in dynamic false condition test.");
        } else {
            result = 1;
        }

        // Assertions
        assert_equals(result, 1, "If statement dynamic false failed.");
    });
    
	// Test for nested if-else, both conditions true
    addFact("Nested If-Else statement (both true)", function() {
        var result = 0;

        if (true) {  // Outer condition
            if (true) {  // Inner condition
                result = 2;
            } else {
                assert_true(false, "Should not reach inner else block in both true test.");
            }
        } else {
            assert_true(false, "Should not reach outer else block in both true test.");
        }

        // Assertions
        assert_equals(result, 2, "Nested If-Else statement (both true) failed.");
    });

    // Test for nested if-else, outer true, inner false
    addFact("Nested If-Else statement (outer true, inner false)", function() {
        var result = 0;

        if (true) {  // Outer condition
            if (false) {  // Inner condition
                assert_true(false, "Should not reach inner if block in inner false test.");
            } else {
                result = 1;  // Inner else executes
            }
        } else {
            assert_true(false, "Should not reach outer else block in inner false test.");
        }

        // Assertions
        assert_equals(result, 1, "Nested If-Else statement (outer true, inner false) failed.");
    });

    // Test for nested if-else, outer false
    addFact("Nested If-Else statement (outer false)", function() {
        var result = 0;

        if (false) {  // Outer condition
            assert_true(false, "Should not reach outer if block in outer false test.");
        } else {
            result = 1;  // Outer else executes
        }

        // Assertions
        assert_equals(result, 1, "Nested If-Else statement (outer false) failed.");
    });

    // Test for nested if-else, outer false, inner true (this scenario would not execute the inner if)
    addFact("Nested If-Else statement (outer false, inner true)", function() {
        var result = 0;

        if (false) {  // Outer condition
            if (true) {  // Inner condition (not executed)
                assert_true(false, "Should not reach inner if block in outer false test.");
            } else {
                assert_true(false, "Should not reach inner else block in outer false test.");
            }
        } else {
            result = 1;  // Outer else executes
        }

        // Assertions
        assert_equals(result, 1, "Nested If-Else statement (outer false, inner true) failed.");
    });
	
	#endregion
	
	#region Repeat
	
	// Test for repeat(0) - should not execute the loop
    addFact("Repeat statement with 0 repetitions", function() {
        var count = 0;

        repeat (0) {
            count++;
        }

        // Assertions
        assert_equals(count, 0, "Repeat statement with 0 repetitions should not modify count.");
    });

    // Test for repeat(0) - should not execute the loop
    addFact("Repeat statement with negative repetitions", function() {
        var count = 0;

        repeat (-1) {
            count++;
        }

        // Assertions
        assert_equals(count, 0, "Repeat statement with negative repetitions should not modify count.");
    });

    // Test for repeat("incorrectValue") - should throw an error
    addFact("Repeat statement with incorrect value (error case)", function() {
        assert_throw(function() {
			repeat ("incorrectValue") {
                // Should not reach this block
				assert_true(false, "Repeat statement with incorrect value should throw an error.");
            }
		}, "Repeat statement with incorrect value should throw an error.")
    });

    // Test for repeat with break
    addFact("Repeat statement with break", function() {
        var count = 0;

        repeat (10) {
            count++;
            if (count == 5) break;
        }

        // Assertions
        assert_equals(count, 5, "Repeat statement with break failed.");
    });

    // Test for repeat with continue
    addFact("Repeat statement with continue", function() {
        var count = 0;
        var sum = 0;

        repeat (10) {
            count++;
            if (count % 2 == 0) continue;
            sum += count;
        }

        // Assertions
        assert_equals(sum, 25, "Repeat statement with continue failed.");
    });

    // Test for repeat with constant value
    addFact("Repeat statement with constant value", function() {
        var count = 0;

        repeat (5) {
            count++;
        }

        // Assertions
        assert_equals(count, 5, "Repeat statement with constant value failed.");
    });

    // Test for repeat with dynamic value
    addFact("Repeat statement with dynamic value", function() {
        var count = 0;
        var repeatValue = 7;

        repeat (repeatValue) {
            count++;
        }

        // Assertions
        assert_equals(count, 7, "Repeat statement with dynamic value failed.");
    });
	
	// Test for inner and outer loops being valid
    addFact("Repeat inner and outer valid", function() {
        var outerCount = 0;
        var innerCount = 0;

        repeat (3) { // Outer loop
            outerCount++;
            repeat (2) { // Inner loop
                innerCount++;
            }
        }

        // Assertions
        assert_equals(outerCount, 3, "Outer repeat loop did not run the expected number of times.");
        assert_equals(innerCount, 6, "Inner repeat loop did not run the expected number of times.");
    });

    // Test for outer loop valid, inner loop invalid (repeat(0))
    addFact("Repeat outer valid, inner invalid", function() {
        var outerCount = 0;
        var innerCount = 0;

        repeat (3) { // Outer loop
            outerCount++;
            repeat (0) { // Inner loop should not run
                assert_true(false, "Inner loop should not execute when invalid.");
            }
        }

        // Assertions
        assert_equals(outerCount, 3, "Outer repeat loop did not run the expected number of times.");
        assert_equals(innerCount, 0, "Inner repeat loop should not run when repeat(0) is used.");
    });

    // Test for outer loop invalid (repeat(0)), inner loop valid
    addFact("Repeat outer invalid, inner valid", function() {
        var outerCount = 0;
        var innerCount = 0;

        repeat (0) { // Outer loop should not run
            outerCount++;
            repeat (2) { // Inner loop should not be reached
                assert_true(false, "Inner loop should not execute when outer loop is invalid.");
            }
        }

        // Assertions
        assert_equals(outerCount, 0, "Outer repeat loop should not run when repeat(0) is used.");
        assert_equals(innerCount, 0, "Inner repeat loop should not run when outer loop is invalid.");
    });

    // Test for both inner and outer loops invalid (repeat(0))
    addFact("Repeat inner and outer invalid", function() {
        var outerCount = 0;
        var innerCount = 0;

        repeat (0) { // Outer loop should not run
            outerCount++;
			assert_true(false, "Outer loop should not execute when invalid.");
            repeat (0) { // Inner loop should not run
                innerCount++;
				assert_true(false, "Inner loop should not execute when invalid.");
            }
        }

        // Assertions
        assert_equals(outerCount, 0, "Outer repeat loop should not run when repeat(0) is used.");
        assert_equals(innerCount, 0, "Inner repeat loop should not run when outer loop is invalid.");
    });
	
	#endregion
	
	#region While
	
    // Test for while with 0 repetitions (should not execute the loop)
    addFact("While loop with 0 iterations", function() {
        var count = 0;

        while (false) {
            count++;
        }

        // Assertions
        assert_equals(count, 0, "While loop with 0 iterations should not modify count.");
    });

    // Test for while with negative repetitions (equivalent to false condition)
    addFact("While loop with false condition (negative equivalent)", function() {
        var count = 0;

        while (-1) {
            count++;
        }

        // Assertions
        assert_equals(count, 0, "While loop with false condition should not modify count.");
    });

    // Test for while with incorrect value (error case)
    addFact("While loop with incorrect value (error case)", function() {
        assert_throw(function() {
            while ("incorrectValue") {
                assert_true(false, "While loop with incorrect value should throw an error.");
            }
        }, "While loop with incorrect value should throw an error.");
    });

    // Test for while loop with break
    addFact("While loop with break", function() {
        var count = 0;

        while (count < 10) {
            count++;
            if (count == 5) break;
        }

        // Assertions
        assert_equals(count, 5, "While loop with break failed.");
    });

    // Test for while loop with continue
    addFact("While loop with continue", function() {
        var count = 0;
        var sum = 0;

        while (count < 10) {
            count++;
            if (count % 2 == 0) continue;
            sum += count;
        }

        // Assertions
        assert_equals(sum, 25, "While loop with continue failed.");
    });

    // Test for while loop with dynamic condition (variable-based condition)
    addFact("While loop with dynamic condition", function() {
        var count = 0;
        var condition = 7;

        while (count < condition) {
            count++;
        }

        // Assertions
        assert_equals(count, 7, "While loop with dynamic condition failed.");
    });

    // Test for inner and outer while loops being valid
    addFact("While inner and outer valid", function() {
        var outerCount = 0;
        var innerCount = 0;

        while (outerCount < 3) { // Outer loop
            outerCount++;
            var innerLoop = 0;
            while (innerLoop < 2) { // Inner loop
                innerLoop++;
                innerCount++;
            }
        }

        // Assertions
        assert_equals(outerCount, 3, "Outer while loop did not run the expected number of times.");
        assert_equals(innerCount, 6, "Inner while loop did not run the expected number of times.");
    });

    // Test for outer loop valid, inner loop invalid (while false)
    addFact("While outer valid, inner invalid", function() {
        var outerCount = 0;
        var innerCount = 0;

        while (outerCount < 3) { // Outer loop
            outerCount++;
            while (false) { // Inner loop should not run
                assert_true(false, "Inner loop should not execute when invalid.");
            }
        }

        // Assertions
        assert_equals(outerCount, 3, "Outer while loop did not run the expected number of times.");
        assert_equals(innerCount, 0, "Inner while loop should not run when condition is false.");
    });

    // Test for outer loop invalid (while false), inner loop valid
    addFact("While outer invalid, inner valid", function() {
        var outerCount = 0;
        var innerCount = 0;

        while (false) { // Outer loop should not run
            outerCount++;
            while (innerCount < 2) { // Inner loop should not be reached
                assert_true(false, "Inner loop should not execute when outer loop is invalid.");
            }
        }

        // Assertions
        assert_equals(outerCount, 0, "Outer while loop should not run when condition is false.");
        assert_equals(innerCount, 0, "Inner while loop should not run when outer loop is invalid.");
    });

    // Test for both inner and outer loops invalid (while false)
    addFact("While inner and outer invalid", function() {
        var outerCount = 0;
        var innerCount = 0;

        while (false) { // Outer loop should not run
            outerCount++;
            assert_true(false, "Outer loop should not execute when invalid.");
            while (false) { // Inner loop should not run
                innerCount++;
                assert_true(false, "Inner loop should not execute when invalid.");
            }
        }

        // Assertions
        assert_equals(outerCount, 0, "Outer while loop should not run when condition is false.");
        assert_equals(innerCount, 0, "Inner while loop should not run when outer loop is invalid.");
    });
	
	#endregion
	
	#region Do Until

    // Test for do...until with 0 repetitions (should not execute the loop because of immediate condition being true)
    addFact("DoUntil loop with immediate condition (do not loop)", function() {
        var count = 0;

        do {
            count++;
        } until (true); // Immediate stop

        // Assertions
        assert_equals(count, 1, "DoUntil loop with immediate condition should run exactly once.");
    });

    // Test for do...until with dynamic condition
    addFact("DoUntil loop with dynamic condition", function() {
        var count = 0;
        var condition = false;

        do {
            count++;
            if (count >= 5) condition = true;
        } until (condition);

        // Assertions
        assert_equals(count, 5, "DoUntil loop with dynamic condition failed.");
    });

    // Test for do...until with break
    addFact("DoUntil loop with break", function() {
        var count = 0;

        do {
            count++;
            if (count == 5) break;
        } until (count == 10); // Should break at count 5, not reach 10

        // Assertions
        assert_equals(count, 5, "DoUntil loop with break failed.");
    });

    // Test for do...until with continue
    addFact("DoUntil loop with continue", function() {
        var count = 0;
        var sum = 0;

        do {
            count++;
            if (count % 2 == 0) continue;
            sum += count;
        } until (count == 10);

        // Assertions
        assert_equals(sum, 25, "DoUntil loop with continue failed.");
    });

    // Test for do...until with constant false condition
    addFact("DoUntil loop with constant condition (false)", function() {
        var count = 0;

        do {
            count++;
        } until (count >= 5); // Constant condition

        // Assertions
        assert_equals(count, 5, "DoUntil loop with constant false condition failed.");
    });

    // Test for inner and outer do...until loops being valid
    addFact("DoUntil inner and outer valid", function() {
        var outerCount = 0;
        var innerCount = 0;

        do {
            outerCount++;
            var innerLoop = 0;
            do {
                innerLoop++;
                innerCount++;
            } until (innerLoop >= 2);
        } until (outerCount >= 3);

        // Assertions
        assert_equals(outerCount, 3, "Outer do...until loop did not run the expected number of times.");
        assert_equals(innerCount, 6, "Inner do...until loop did not run the expected number of times.");
    });

    // Test for outer loop valid, inner loop invalid (do nothing for inner)
    addFact("DoUntil outer valid, inner invalid", function() {
        var outerCount = 0;
        var innerCount = 0;

        do {
            outerCount++;
            do { // Inner loop should not run
				innerCount++;
            } until (true); // Immediate stop for inner loop
        } until (outerCount >= 3);

        // Assertions
        assert_equals(outerCount, 3, "Outer do...until loop did not run the expected number of times.");
        assert_equals(innerCount, 3, "Inner do...until loop did not run the expected number of times.");
    });

    // Test for outer loop invalid (do not run), inner loop valid
    addFact("DoUntil outer invalid, inner valid", function() {
        var outerCount = 0;
        var innerCount = 0;

        do { // Outer loop should not run
            outerCount++;
            do {
				innerCount++
            } until (innerCount >= 2);
        } until (true); // Outer loop condition is false immediately

        // Assertions
        assert_equals(outerCount, 1, "Outer do...until loop did not run the expected number of times.");
        assert_equals(innerCount, 2, "Inner do...until loop did not run the expected number of times.");
    });

    // Test for both inner and outer loops invalid (do not run)
    addFact("DoUntil inner and outer invalid", function() {
        var outerCount = 0;
        var innerCount = 0;

        do { // Outer loop should not run
            outerCount++;
            do { // Inner loop should not run
                innerCount++;
            } until (true);
        } until (true);

        // Assertions
        assert_equals(outerCount, 1, "Outer do...until loop did not run the expected number of times.");
        assert_equals(innerCount, 1, "Inner do...until loop did not run the expected number of times.");
    });
	
	#endregion
	
	#region For

    // Test for for loop with 0 iterations (immediate stop)
    addFact("For loop with 0 iterations", function() {
        var count = 0;

        for (var i = 0; i < 0; i++) {
            count++;
        }

        // Assertions
        assert_equals(count, 0, "For loop with 0 iterations should not modify count.");
    });

    // Test for for loop with negative iterations (immediate stop)
    addFact("For loop with negative iterations", function() {
        var count = 0;

        for (var i = 0; i < -1; i++) {
            count++;
        }

        // Assertions
        assert_equals(count, 0, "For loop with negative iterations should not modify count.");
    });

    // Test for for loop with dynamic condition
    addFact("For loop with dynamic condition", function() {
        var count = 0;
        var maxIterations = 5;

        for (var i = 0; i < maxIterations; i++) {
            count++;
        }

        // Assertions
        assert_equals(count, 5, "For loop with dynamic condition failed.");
    });

    // Test for for loop with break
    addFact("For loop with break", function() {
        var count = 0;

        for (var i = 0; i < 10; i++) {
            count++;
            if (count == 5) break;
        }

        // Assertions
        assert_equals(count, 5, "For loop with break failed.");
    });

    // Test for for loop with continue
    addFact("For loop with continue", function() {
        var count = 0;
        var sum = 0;

        for (var i = 0; i < 10; i++) {
            count++;
            if (count % 2 == 0) continue;
            sum += count;
        }

        // Assertions
        assert_equals(sum, 25, "For loop with continue failed.");
    });

    // Test for for loop with constant iterations
    addFact("For loop with constant iterations", function() {
        var count = 0;

        for (var i = 0; i < 5; i++) {
            count++;
        }

        // Assertions
        assert_equals(count, 5, "For loop with constant iterations failed.");
    });

    // Test for inner and outer for loops both valid
    addFact("For loop inner and outer valid", function() {
        var outerCount = 0;
        var innerCount = 0;

        for (var i = 0; i < 3; i++) { // Outer loop
            outerCount++;
            for (var j = 0; j < 2; j++) { // Inner loop
                innerCount++;
            }
        }

        // Assertions
        assert_equals(outerCount, 3, "Outer for loop did not run the expected number of times.");
        assert_equals(innerCount, 6, "Inner for loop did not run the expected number of times.");
    });

    // Test for outer loop valid, inner loop invalid (for loop with 0 iterations)
    addFact("For loop outer valid, inner invalid", function() {
        var outerCount = 0;
        var innerCount = 0;

        for (var i = 0; i < 3; i++) { // Outer loop
            outerCount++;
            for (var j = 0; j < 0; j++) { // Inner loop should not run
                assert_true(false, "Inner loop should not execute when invalid.");
            }
        }

        // Assertions
        assert_equals(outerCount, 3, "Outer for loop did not run the expected number of times.");
        assert_equals(innerCount, 0, "Inner for loop should not run when invalid.");
    });

    // Test for outer loop invalid (for loop with 0 iterations), inner loop valid
    addFact("For loop outer invalid, inner valid", function() {
        var outerCount = 0;
        var innerCount = 0;

        for (var i = 0; i < 0; i++) { // Outer loop should not run
            outerCount++;
            for (var j = 0; j < 2; j++) { // Inner loop should not be reached
                assert_true(false, "Inner loop should not execute when outer loop is invalid.");
            }
        }

        // Assertions
        assert_equals(outerCount, 0, "Outer for loop should not run when iterations are 0.");
        assert_equals(innerCount, 0, "Inner for loop should not run when outer loop is invalid.");
    });

    // Test for both inner and outer for loops invalid (for loop with 0 iterations)
    addFact("For loop inner and outer invalid", function() {
        var outerCount = 0;
        var innerCount = 0;

        for (var i = 0; i < 0; i++) { // Outer loop should not run
            outerCount++;
            assert_true(false, "Outer loop should not execute when invalid.");
            for (var j = 0; j < 0; j++) { // Inner loop should not run
                innerCount++;
                assert_true(false, "Inner loop should not execute when invalid.");
            }
        }

        // Assertions
        assert_equals(outerCount, 0, "Outer for loop should not run when iterations are 0.");
        assert_equals(innerCount, 0, "Inner for loop should not run when outer loop is invalid.");
    });
	
	#endregion
	
	#region Switch Case Default

	// Constant Expression
	addFact("Switch statement with constant expression", function() {
	    var result = 0;
    
	    switch (3) {
	        case 1:
	            result = 1;
				assert_true(false, "Should not reach case 1 for constant expression.");
	            break;
	        case 2:
	            result = 2;
				assert_true(false, "Should not reach case 2 for constant expression.");
	            break;
	        case 3:
	            result = 3;  // Expected to hit this case
	            break;
	        default:
	            assert_true(false, "Should not reach default case for constant expression.");
	    }
    
	    // Assertions
	    assert_equals(result, 3, "Switch with constant expression failed.");
	});

	// Dynamic Expression
	addFact("Switch statement with dynamic expression", function() {
	    var result = 0;
	    var value = 2;
    
	    switch (value) {
	        case 1:
	            result = 1;
				assert_true(false, "Should not reach case 1 for constant expression.");
	            break;
	        case 2:
	            result = 2;  // Expected to hit this case
	            break;
	        case 3:
	            result = 3;
				assert_true(false, "Should not reach case 3 for constant expression.");
	            break;
	        default:
	            assert_true(false, "Should not reach default case for dynamic expression.");
	    }
    
	    // Assertions
	    assert_equals(result, 2, "Switch with dynamic expression failed.");
	});

	// Incorrect Expression (Should fall to default)
	addFact("Switch statement default with incorrect expression", function() {
	    var result = 0;
    
	    switch (5) {  // No matching case
	        case 1:
	            result = 1;
				assert_true(false, "Should not reach case 1 for constant expression.");
	            break;
	        case 2:
	            result = 2;
				assert_true(false, "Should not reach case 2 for constant expression.");
	            break;
	        default:
	            result = -1;  // Expected to hit default case
	    }
    
	    // Assertions
	    assert_equals(result, -1, "Switch with incorrect expression did not hit default.");
	});

	// Breaks
	// Incorrect Expression (Should not execute)
	addFact("Switch statement with incorrect expression", function() {
	    var result = 0;
    
	    switch (5) {  // No matching case
	        case 1:
	            result = 1;
				assert_true(false, "Should not reach case 1 for constant expression.");
	            break;
	        case 2:
	            result = 2;
				assert_true(false, "Should not reach case 2 for constant expression.");
	            break;
	    }
    
	    // Assertions
	    assert_equals(result, 0, "Switch with no case or default should not be written to");
	});

	
	addFact("Switch statement without breaks", function() {
	    var result = 0;
    
	    switch (1) {
	        case 1:
	            result += 1;
	        case 2:
	            result += 2;
	        default:
				result += 3;
	    }
    
	    // Assertions
	    assert_equals(result, 6, "Switch without breaks failed.");
	});

	// Inner and Outer Switches
	addFact("Switch statement with inner and outer switch", function() {
	    var result = 0;
    
	    switch (1) {  // Outer switch
	        case 1:
	            switch (2) {  // Inner switch
	                case 2:
	                    result = 5;  // Expected to hit this case
	                    break;
	                default:
	                    assert_true(false, "Inner switch did not behave as expected.");
	            }
	            break;
	        default:
	            assert_true(false, "Outer switch did not behave as expected.");
	    }
    
	    // Assertions
	    assert_equals(result, 5, "Switch with inner and outer switch failed.");
	});

	// Case Result with Break
	addFact("Switch statement case result with break", function() {
	    var result = 0;
    
	    switch (3) {
	        case 1:
	            result = 1;
				assert_true(false, "Should not reach case 1 for constant expression.");
	            break;
	        case 2:
	            result = 2;
				assert_true(false, "Should not reach case 2 for constant expression.");
	            break;
	        case 3:
	            result = 3;  // Expected to hit this case
	            break;
	        default:
	            result = -1;
				assert_true(false, "Should not reach default case for constant expression.");
	    }
    
	    // Assertions
	    assert_equals(result, 3, "Switch case with break failed.");
	});

	// Multiple Case Results
	addFact("Switch statement multiple case results", function() {
	    var result = 0;
    
	    switch (3) {
	        case 1:
	        case 2:
	            result = 2;
				assert_true(false, "Should not reach case 1/2 for constant expression.");
	            break;
	        case 3:
	        case 4:
	            result = 3;  // Expected to hit this case
	            break;
	        default:
	            assert_true(false, "Should not reach default case for multiple case results.");
	    }
    
	    // Assertions
	    assert_equals(result, 3, "Switch with multiple case results failed.");
	});

	// Default Result
	addFact("Switch statement default result", function() {
	    var result = 0;
    
	    switch (6) {  // No matching case
	        case 1:
	            result = 1;
				assert_true(false, "Should not reach case 1 for constant expression.");
	            break;
	        case 2:
	            result = 2;
				assert_true(false, "Should not reach case 2 for constant expression.");
	            break;
	        default:
	            result = -1;  // Expected to hit default case
	    }
    
	    // Assertions
	    assert_equals(result, -1, "Switch with default result failed.");
	});

	// Multiple Case Results with Fall Through to Default
	addFact("Switch statement multiple cases fall through to default", function() {
	    var result = 0;
    
	    switch (5) {  // No matching case
	        case 1:
	        case 2:
	            result = 2;
				assert_true(false, "Should not reach case 1/2 for constant expression.");
	            break;
	        case 3:
	        case 4:
	            result = 3;
				assert_true(false, "Should not reach case 3/4 for constant expression.");
	            break;
	        default:
	            result = -1;  // Expected to hit default case
	    }
    
	    // Assertions
	    assert_equals(result, -1, "Switch with multiple cases falling to default failed.");
	});

	#endregion
	
	#region With Statement Tests

	// Test targeting a single object instance
	addFact("With statement targeting a single object instance", function() {
	    var obj_ball = instance_create_layer(100, 100, "Instances", oEmpty);
	    obj_ball.y = 100;
    
	    with (obj_ball) {
	        y += 50;  // Should move this specific instance down by 50
	    }
    
	    // Assertions
	    assert_equals(obj_ball.y, 150, "With statement targeting a single object instance failed.");
		
		//Clean Up
		instance_destroy(obj_ball);
	});

	// Test targeting all instances of an object group
	addFact("With statement targeting object group", function() {
	    var obj_ball1 = instance_create_layer(100, 100, "Instances", oEmpty);
	    var obj_ball2 = instance_create_layer(200, 100, "Instances", oEmpty);
	    obj_ball1.y = 100;
	    obj_ball2.y = 200;
    
	    with (oEmpty) {
	        y += 50;  // Should move both instances down by 50
	    }
    
	    // Assertions
	    assert_equals(obj_ball1.y, 150, "With statement targeting object group (first instance) failed.");
	    assert_equals(obj_ball2.y, 250, "With statement targeting object group (second instance) failed.");
		
		//Clean Up
		instance_destroy(obj_ball1);
		instance_destroy(obj_ball2);
	});

	// Test with noone (no action should occur)
	addFact("With statement with noone", function() {
	    var result = 0;
    
	    with (noone) {
	        result = 1;  // This should not execute
			assert_true(false, "With noone entered unreachable code");
	    }
    
	    // Assertions
	    assert_equals(result, 0, "With statement with noone should not modify result.");
	});

	// Test with all
	addFact("With statement with all", function() {
	    var result = 0;
		
	    with (all) {
	        result = 1;  // This should not execute
	    }
    
	    // Assertions
	    assert_not_equals(result, 0, "With statement with all should modify result.");
	});
	
	// Test with self
	addFact("With statement with self", function() {
	    var instance = instance_create_layer(100, 100, "Instances", oEmpty);
		instance.y = 100;
		
		with (instance) {
		    with (self) {
		        y += 50;  // Should modify the current instance (self)
		    }
		}
	    // Assertions
	    assert_equals(instance.y, 150, "With statement with self failed.");
		
		//Clean Up
		instance_destroy(instance);
	});

	// Test with global
	addFact("With statement with global", function() {
	    global.x = 50;
    
	    with (global) {
	        x += 50;  // Should modify the global scope
	    }
    
	    // Assertions
	    assert_equals(global.x, 100, "With statement with global failed.");
		
		// Clean Up
		struct_remove(global, "x");
	});
	
	// Test with break
	addFact("With statement with break", function() {
	    var obj_ball1 = instance_create_layer(100, 100, "Instances", oEmpty);
	    var obj_ball2 = instance_create_layer(200, 100, "Instances", oEmpty);
	    obj_ball1.hp = 100;
	    obj_ball2.hp = 100;
    
	    var _count = 0;
	    with (oEmpty) {
	        if (++_count == 1) break;  // Should only modify the first instance
	        hp = 200;
	    }
    
	    // Assertions
	    assert_equals(obj_ball1.hp, 100, "With statement with break modified the first instance unexpectedly.");
	    assert_equals(obj_ball2.hp, 100, "With statement with break failed to stop after the first instance.");
		
		//Clean Up
		instance_destroy(obj_ball1);
		instance_destroy(obj_ball2);
	});

	// Test with continue
	addFact("With statement with continue", function() {
	    var obj_ball1 = instance_create_layer(100, 100, "Instances", oEmpty, {hp: 0});
	    var obj_ball2 = instance_create_layer(200, 100, "Instances", oEmpty, {hp: 0});
	    obj_ball1.invulnerable = true;
	    obj_ball2.invulnerable = false;
    
	    with (oEmpty) {
	        if (invulnerable) continue;  // Should skip the first instance
	        hp -= 50;
	    }
    
	    // Assertions
	    assert_equals(obj_ball1.hp, 0, "With statement with continue failed to skip the first instance.");
	    assert_equals(obj_ball2.hp, -50, "With statement with continue failed to modify the second instance.");
		
		//Clean Up
		instance_destroy(obj_ball1);
		instance_destroy(obj_ball2);
	});

	// Test nested with statements
	addFact("With statement nested", function() {
	    var obj_ball = instance_create_layer(100, 100, "Instances", oEmpty);
	    obj_ball.speed = 0;
    
	    with (obj_ball) {
	        speed = 2;
	        with (self) {  // Nested with self
	            speed *= 2;  // Should double the speed
	        }
	    }
    
	    // Assertions
	    assert_equals(obj_ball.speed, 4, "Nested with statements failed.");
		
		//Clean Up
		instance_destroy(obj_ball);
	});

	// Test with new instance creation
	addFact("With statement with new instance creation", function() {
	    var new_ball;
    
	    with (instance_create_layer(150, 150, "Instances", oEmpty)) {
			new_ball = self
	        speed = 5;  // Should set the speed of the new instance
	    }
    
	    // Assertions
	    assert_equals(new_ball.speed, 5, "With statement with new instance creation failed.");
		
		//Clean Up
		instance_destroy(new_ball);
	});

	// Test with struct target
	addFact("With statement with struct", function() {
	    var struct = {x: 0, y: 0};
    
	    with (struct) {
	        x = 100;
	        y = 200;
	    }
    
	    // Assertions
	    assert_equals(struct.x, 100, "With statement with struct (x) failed.");
	    assert_equals(struct.y, 200, "With statement with struct (y) failed.");
	});

	#endregion

	#region Try/Catch/Finally Statement Tests

	// Test for basic try without an error
	addFact("Try without Error", function() {
	    var result = 0;
    
	    try {
	        result += 1;
	    }
    
	    // Assertions
	    assert_equals(result, 1, "Try without error failed.");
	});

	// Test for try with an error
	addFact("Try with Error", function() {
	    assert_throw(function(){
			var result = 0;
			
		    try {
		        throw "Error";
		        result += 1;
				assert_true(false, "Continued block statement after error.");
		    }
			
		    // Assertions
		    assert_equals(result, 0, "Try with error failed.");
		}, "Try without Catch should throw an error")
	});

	// Test for try with finally block
	addFact("Try/Finally without Error", function() {
	    var result = 0;
    
	    try {
	        result += 1;
	    } finally {
	        result += 2;
	    }
    
	    // Assertions
	    assert_equals(result, 3, "Finally did not execute as expected");
	});

	// Test for try with finally block
	addFact("Try/Finally with Error", function() {
	    assert_throw(function(){
			var result = 0;
			
		    try {
				throw "Error"
		        result += 1;
				assert_true(false, "Continued block statement after error.");
		    } finally {
		        result += 2;
		    }
			
		    // Assertions
		    assert_equals(result, 2, "Try with finally failed.");
		}, "Try without Catch should throw an error")
	});

	// Test for try-catch with an error
	addFact("Try/Catch without Error", function() {
	    var result = 0;
    
	    try {
	        result += 1;  // This should not execute
	    } catch (e) {
	        result += 2;  // This should execute
			assert_true(false, "Continued block statement after error.");
	    }
    
	    // Assertions
	    assert_equals(result, 1, "Try/Catch without error failed.");
	});

	// Test for try-catch with an error
	addFact("Try/Catch with Error", function() {
	    var result = 0;
    
	    try {
	        throw "Error";
	        result += 1;
			assert_true(false, "Continued block statement after error.");
	    } catch (e) {
	        result += 2;  // This should execute
	    }
    
	    // Assertions
	    assert_equals(result, 2, "Try/Catch with error failed.");
	});

	// Test for try-catch-finally with an error
	addFact("Try/Catch/Finally without Error", function() {
	    var result = 0;
    
	    try {
	        result += 1;
	    } catch (e) {
	        result += 2;
			assert_true(false, "Continued block statement after error.");
	    } finally {
	        result += 4;
	    }
    
	    // Assertions
	    assert_equals(result, 5, "Try/Catch/Finally without error failed.");
	});

	// Test for try-catch-finally with an error
	addFact("Try/Catch/Finally with Error", function() {
	    var result = 0;
    
	    try {
	        throw "Error";
	        result += 1;
			assert_true(false, "Continued block statement after error.");
	    } catch (e) {
	        result += 2;
	    } finally {
	        result += 4;
	    }
    
	    // Assertions
	    assert_equals(result, 6, "Try/Catch/Finally with error failed.");
	});

	// Test for nested try-catch blocks
	addFact("Nested/Try/Catch", function() {
	    var result = 0;
    
	    try {
	        try {
	            throw "Error";
				result += 1
				assert_true(false, "Continued block statement after error.");
	        } catch (e) {
	            result += 2;
	        }
	    } catch (e) {
	        result += 4;
			assert_true(false, "Continued block statement after error.");
	    }
    
	    // Assertions
	    assert_equals(result, 2, "Nested Try/Catch failed.");
	});

	// Test for nested try-finally blocks
	addFact("Nested Try/Finally", function() {
	    var result = 0;
    
	    try {
	        try {
	            result += 1;
	        } finally {
	            result += 2;
	        }
	    } finally {
	        result += 4;
	    }
    
	    // Assertions
	    assert_equals(result, 7, "Nested Try/Finally failed.");
	});

	// Test for try with break inside a loop
	addFact("Try with Break", function() {
	    var result = 0;
    
	    for (var i = 0; i < 3; i++) {
	        try {
	            if (i == 1) break;  // Should break the loop
	            result += i;
	        } catch (e) {
	            assert_true(false, "Should not reach the catch block.");
	        }
	    }
    
	    // Assertions
	    assert_equals(result, 0, "Try with break failed.");
	});

	// Test for try with continue inside a loop
	addFact("Try with Continue", function() {
	    var result = 0;
    
	    for (var i = 0; i < 3; i++) {
	        try {
	            if (i == 1) continue;  // Should continue the loop
	            result += i;
	        } catch (e) {
	            assert_true(false, "Should not reach the catch block.");
	        }
	    }
    
	    // Assertions
	    assert_equals(result, 2, "Try with continue failed.");
	});

	// Test for try-catch-finally with continue
	addFact("Try/Catch/Finally with Continue", function() {
	    var result = 0;
    
	    for (var i = 0; i < 3; i++) {
	        try {
	            if (i == 1) continue;  // Should continue the loop
	            result += i;
	        } catch (e) {
	            assert_true(false, "Should not reach the catch block.");
	        } finally {
	            result += 4;  // Should execute after continue
	        }
	    }
    
	    // Assertions
	    assert_equals(result, 14, "Try-catch-finally with continue failed.");
	});

	// Test for advanced try with nested try-catch-finally
	addFact("Advanced Try/Catch/Finally Nested", function() {
	    var result = 0;
    
	    try {
	        try {
	            throw "Error";  // Should trigger inner catch
				result += 1;
				assert_true(false, "Continued block statement after error.");
	        } catch (e) {
	            result += 2;
	        } finally {
	            result += 4;
	        }
	    } catch (e) {
	        result += 8;
			assert_true(false, "Continued block statement after error.");
	    } finally {
	        result += 16;
	    }
    
	    // Assertions
	    assert_equals(result, 22, "Advanced Try/Catch/Finally Nested failed.");
	});

	// Test for advanced try-catch-finally with continue and break in nested loops
	addFact("Advanced Try/Catch/Finally with Continue and Break", function() {
	    var result = 0;
    
	    for (var i = 0; i < 3; i++) {
	        try {
	            if (i == 1) continue;
	            if (i == 2) break;
	            result += i;
	        } catch (e) {
	            assert_true(false, "Should not reach the catch block.");
	        } finally {
	            result += 4;
	        }
	    }
    
	    // Assertions
	    assert_equals(result, 12, "Advanced try-catch-finally with continue and break failed.");
	});

	// Test for advanced try-finally with nested loops
	addFact("Advanced Try Finally with Nested Loops", function() {
	    var result = 0;
    
	    for (var i = 0; i < 3; i++) {
	        try {
	            for (var j = 0; j < 3; j++) {
	                if (i == 1 && j == 1) continue;  // Should skip
	                if (i == 2 && j == 2) break;  // Should break
	                result += i * 10 + j;
	            }
	        } finally {
	            result += 100 * i;
	        }
	    }
    
	    // Assertions
	    assert_equals(result, 366, "Advanced try-finally with nested loops failed.");
	});

	// Test for advanced try-catch with return inside a loop
	addFact("Advanced Try Catch with Return Inside Loop", function() {
	    var result = 0;
    
	    for (var i = 0; i < 3; i++) {
	        try {
	            if (i == 1) throw "Error";  // Should trigger the catch
	            result += i;
	        } catch (e) {
	            result += 10 + i;
	        }
	    }
    
	    // Assertions
	    assert_equals(result, 13, "Advanced try-catch with return inside loop failed.");
	});

	// Test for advanced try with continue and break in nested loops
	addFact("Advanced Try with Continue and Break in Nested Loops", function() {
	    var result = 0;
    
	    for (var i = 0; i < 3; i++) {
	        try {
	            for (var j = 0; j < 3; j++) {
	                if (i == 1) continue;
	                if (j == 1) break;
	                result += i * 10 + j;
	            }
	        } finally {
	            result += 100 + i;
	        }
	    }
    
	    // Assertions
	    assert_equals(result, 323, "Advanced try with continue and break in nested loops failed.");
	});

	#endregion

}


