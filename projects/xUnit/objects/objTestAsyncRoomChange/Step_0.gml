/// @description Insert description here
// You can write your code in this editor

if (test_has_expired()) {
	return test_end(TestResult.Expired);
}

test_run_event("ev_step");

