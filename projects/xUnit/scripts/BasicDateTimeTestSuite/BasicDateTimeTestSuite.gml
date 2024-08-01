
function BasicDateTimeTestSuite() : TestSuite() constructor {

	// DATE CREATE TESTS

	addFact("date_create_datetime_test #1", function() {
		
		var _value = date_create_datetime(2011, 9, 15, 9, 43, 44);
			
		//#1 typeof ( datetime )
		assert_typeof(_value, "number", "typeof ( datetime ), should of type numeric");
		
	});
	
	addFact("date_create_datetime_test #2", function() {
		
		var _value = date_create_datetime(2011, 9, 15, 9, 43, 44);
			
		//#2 typeof ( datetime )
		assert_not_undefined(_value, "datetime should not be undefined");
		
	});
	
	addFact("date_create_datetime_test #3", function() {
		
		var _value = date_create_datetime(2011, 9, 15, 9, 43, 44);

		//#3 typeof ( datetime )
		assert_not_null(_value, "datetime should not be null");
		
	});
	
	// DATE CURRENT TESTS
		
	addFact("date_current_datetime_test #1", function() {
		
		var value = date_current_datetime();
			
		//#1 typeof ( current_datetime )
		assert_typeof(value, "number", "typeof ( current_datetime ), should of type numeric");
		
	});
	
	addFact("date_current_datetime_test #2", function() {
		
		var value = date_current_datetime();
			
		//#2 typeof ( current_datetime )
		assert_not_undefined(value, "current_datetime should not be undefined");
		
	});
	
	addFact("date_current_datetime_test #3", function() {
		
		var value = date_current_datetime();

		//#3 typeof ( current_datetime )
		assert_not_null(value, "current_datetime should not be null");
		
	});
	
	// DATE GET TESTS
		
	addFact("date_get_test #1", function() {

		var output, input = date_create_datetime(2011, 9, 15, 9, 43, 44);
			
		//#1 date_get_year( datetime )
		output = date_get_year(input);
		assert_equals(output, 2011, "date_get_year( datetime ), returned the wrong value");

	});
	
	addFact("date_get_test #2", function() {

		var output, input = date_create_datetime(2011, 9, 15, 9, 43, 44);
			
		//#2 date_get_month( datetime )
		output = date_get_month(input);
		assert_equals(output, 9, "date_get_month( datetime ), returned the wrong value");

	});
	
	addFact("date_get_test #3", function() {

		var output, input = date_create_datetime(2011, 9, 15, 9, 43, 44);
			
		//#3 date_get_day( datetime )
		output = date_get_day(input);
		assert_equals(output, 15, "date_get_day( datetime ), returned the wrong value");

	});
	
	addFact("date_get_test #4", function() {

		var output, input = date_create_datetime(2011, 9, 15, 9, 43, 44);
			
		//#4 date_get_hour( datetime )
		output = date_get_hour(input);
		assert_equals(output, 9, "date_get_hour( datetime ), returned the wrong value");

	});
	
	addFact("date_get_test #5", function() {

		var output, input = date_create_datetime(2011, 9, 15, 9, 43, 44);
			
		//#5 date_get_minute( datetime )
		output = date_get_minute(input);
		assert_equals(output, 43, "date_get_minute( datetime ), returned the wrong value");

	});
	
	addFact("date_get_test #6", function() {

		var output, input = date_create_datetime(2011, 9, 15, 9, 43, 44);
			
		//#6 date_get_second( datetime )
		output = date_get_second(input);
		assert_equals(output, 44, "date_get_second( datetime ), returned the wrong value");

	});
	
	addFact("date_get_test #7", function() {

		var output, input = date_create_datetime(2011, 9, 15, 9, 43, 44);
			
		//#7 date_get_week( datetime )
		output = date_get_week(input);
		assert_equals(output, 36, "date_get_week( datetime ), returned the wrong value");

	});
	
	addFact("date_get_test #8", function() {

		var output, input = date_create_datetime(2011, 9, 15, 9, 43, 44);
			
		//#8 date_get_weekday( datetime )
		output = date_get_weekday(input);
		assert_equals(output, 4, "date_get_weekday( datetime ), returned the wrong value");

	});
	
	addFact("date_get_test #9", function() {

		var output, input = date_create_datetime(2011, 9, 15, 9, 43, 44);
			
		//#9 date_get_day_of_year( datetime )
		output = date_get_day_of_year(input);
		assert_equals(output, 258, "date_get_day_of_year( datetime ), returned the wrong value");

	});
	
	addFact("date_get_test #10", function() {

		var output, input = date_create_datetime(2011, 9, 15, 9, 43, 44);
			
		//#10 date_get_hour_of_year( datetime )
		output = date_get_hour_of_year(input);
		assert_equals(output, 6177, "date_get_hour_of_year( datetime ), returned the wrong value");

	});
	
	addFact("date_get_test #11", function() {

		var output, input = date_create_datetime(2011, 9, 15, 9, 43, 44);
			
		//#11 date_get_minute_of_year( datetime )
		output = date_get_minute_of_year(input);
		assert_equals(output, 370663, "date_get_minute_of_year( datetime ), returned the wrong value");

	});
	
	addFact("date_get_test #12", function() {

		var output, input = date_create_datetime(2011, 9, 15, 9, 43, 44);
			
		//#12 date_get_second_of_year( datetime )
		output = date_get_second_of_year(input);
		assert_equals(output, 22239824, "date_get_second_of_year( datetime ), returned the wrong value");

	});
	
	addFact("date_get_test #13", function() {

		var output, input = date_create_datetime(2011, 9, 15, 9, 43, 44);
			
		//#13 date_is_today( datetime )
		output = date_is_today(input);
		assert_false(output, "date_is_today( datetime ), returned the wrong value");

	});
	
	addFact("date_get_test #14", function() {

		var output, input = date_create_datetime(2011, 9, 15, 9, 43, 44);
			
		//#14 date_leap_year( datetime )
		output = date_leap_year(input);
		assert_false(output, "date_leap_year( datetime ), returned the wrong value");

	});
	
	addFact("date_get_test #15", function() {

		var output, input = date_create_datetime(2011, 9, 15, 9, 43, 44);
			
		//#15 date_days_in_month( datetime )
		output = date_days_in_month(input);
		assert_equals(output, 30, "date_days_in_month( datetime ), returned the wrong value");

	});
	
	addFact("date_get_test #16", function() {

		var output, input = date_create_datetime(2011, 9, 15, 9, 43, 44);
			
		//#16 date_days_in_year( datetime )
		output = date_days_in_year(input);
		assert_equals(output, 365, "date_days_in_year( datetime ), returned the wrong value");

	});
	
	// DATE INC TESTS
	
	addFact("date_inc_test #1", function() {
			
		var output, input = date_create_datetime(2011, 9, 15, 9, 43, 44);

		//#1 date_inc_day( 1 )
		output = date_inc_day(input, 1);
		assert_equals(date_get_day(output), 16, "date_inc_day( 1 ) incremented day for datetime");

	});
	
	addFact("date_inc_test #2", function() {
			
		var output, input = date_create_datetime(2011, 9, 15, 9, 43, 44);
			
		//#1.1 date_inc_day( -1 )
		output = date_inc_day(input, -1);
		assert_equals(date_get_day(output), 14, "date_inc_day( -1 ) incremented day for datetime");

	});
	
	addFact("date_inc_test #3", function() {
			
		var output, input = date_create_datetime(2011, 9, 15, 9, 43, 44);
			
		//#1.2 date_inc_day( 20 )
		output = date_inc_day(input, 20);
		assert_equals(date_get_day(output), 5, "date_inc_day( 20 ), overflow number of days");

	});
	
	addFact("date_inc_test #4", function() {
			
		var output, input = date_create_datetime(2011, 9, 15, 9, 43, 44);
			
		//#1.2 date_inc_day( 20 )
		output = date_inc_day(input, 20);
		assert_equals(date_get_month(output), date_get_month(input) + 1, "date_inc_day( 20 ), should go to next month");

	});
	
	addFact("date_inc_test #5", function() {
			
		var output, input = date_create_datetime(2011, 9, 15, 9, 43, 44);
			
		//#2 date_inc_month( 1 )
		output = date_inc_month(input, 1);
		assert_equals(date_get_month(output), 10, "date_inc_month( 1 ) incremented month for datetime");

	});
	
	addFact("date_inc_test #6", function() {
			
		var output, input = date_create_datetime(2011, 9, 15, 9, 43, 44);
			
		//#2.1 date_inc_month( -1 )
		output = date_inc_month(input, -1);
		assert_equals(date_get_month(output), 8, "date_inc_month( -1 ) incremented month for datetime");

	});
	
	addFact("date_inc_test #7", function() {
			
		var output, input = date_create_datetime(2011, 9, 15, 9, 43, 44);
			
		//#2.2 date_inc_month( 11 )
		output = date_inc_month(input, 11);
		assert_equals(date_get_month(output), 8, "date_inc_month( 11 ) overflow number of months");
		assert_equals(date_get_year(output), date_get_year(input) + 1, "#2.2.1 date_inc_month( 11 ), should go to next year");

	});
	
	addFact("date_inc_test #8", function() {
			
		var output, input = date_create_datetime(2011, 9, 15, 9, 43, 44);
			
		//#2.2 date_inc_month( 11 )
		output = date_inc_month(input, 11);
		assert_equals(date_get_year(output), date_get_year(input) + 1, "date_inc_month( 11 ), should go to next year");

	});
	
	addFact("date_inc_test #9", function() {
			
		var output, input = date_create_datetime(2011, 9, 15, 9, 43, 44);
			
		//#3 date_inc_year( 1 )
		output = date_inc_year(input, 1);
		assert_equals(date_get_year(output), 2012, "date_inc_year( 1 ) incremented year for datetime");

	});

	addFact("date_inc_test #10", function() {
			
		var output, input = date_create_datetime(2011, 9, 15, 9, 43, 44);
			
		//#3.1 date_inc_year( -1 )
		output = date_inc_year(input, -1);
		assert_equals(date_get_year(output), 2010, "date_inc_year( -1 ) incremented year for datetime");

	});
	
	addFact("date_inc_test #11", function() {
			
		var output, input = date_create_datetime(2011, 9, 15, 9, 43, 44);
			
		//#4 date_inc_hour( 1 )
		output = date_inc_hour(input, 1);
		assert_equals(date_get_hour(output), 10, "date_inc_hour( 1 ) incremented hour for datetime");

	});
	
	addFact("date_inc_test #12", function() {
			
		var output, input = date_create_datetime(2011, 9, 15, 9, 43, 44);
			
		//#4.1 date_inc_hour( -1 )
		output = date_inc_hour(input, -1);
		assert_equals(date_get_hour(output), 8, "date_inc_hour( -1 ) incremented hour for datetime");

	});
	
	addFact("date_inc_test #13", function() {
			
		var output, input = date_create_datetime(2011, 9, 15, 9, 43, 44);
			
		//#4.2 date_inc_hour( 30 )
		output = date_inc_hour(input, 30);
		assert_equals(date_get_hour(output), 15, "date_inc_hour( 30 ) overflow number of hours");
		assert_equals(date_get_day(output), date_get_day(input) + 1, "date_inc_hour( 30 ), should go to next day");

	});
	
	addFact("date_inc_test #14", function() {
			
		var output, input = date_create_datetime(2011, 9, 15, 9, 43, 44);
			
		//#4.2 date_inc_hour( 30 )
		output = date_inc_hour(input, 30);
		assert_equals(date_get_day(output), date_get_day(input) + 1, "date_inc_hour( 30 ), should go to next day");

	});
	
	addFact("date_inc_test #15", function() {
			
		var output, input = date_create_datetime(2011, 9, 15, 9, 43, 44);
			
		//#5 date_inc_minute( 1 )
		output = date_inc_minute(input, 1);
		assert_equals(date_get_minute(output), 44, "date_inc_minute( 1 ) incremented minute for datetime");

	});
	
	addFact("date_inc_test #16", function() {
			
		var output, input = date_create_datetime(2011, 9, 15, 9, 43, 44);
			
		//#5.1 date_inc_minute( -1 )
		output = date_inc_minute(input, -1);
		assert_equals(date_get_minute(output), 42, "date_inc_minute( -1 ) incremented minute for datetime");

	});
	
	addFact("date_inc_test #17", function() {
			
		var output, input = date_create_datetime(2011, 9, 15, 9, 43, 44);
			
		//#5.2 date_get_minute( 17 )
		output = date_inc_minute(input, 17);
		assert_equals(date_get_minute(output), 0, "date_inc_minute( 17 ) overflow number of nimutes");
		assert_equals(date_get_hour(output), date_get_hour(input) + 1, "date_inc_minute( 17 ), should go to next hour");

	});
	
	addFact("date_inc_test #18", function() {
			
		var output, input = date_create_datetime(2011, 9, 15, 9, 43, 44);
			
		//#5.2 date_get_minute( 17 )
		output = date_inc_minute(input, 17);
		assert_equals(date_get_hour(output), date_get_hour(input) + 1, "date_inc_minute( 17 ), should go to next hour");

	});
	
	addFact("date_inc_test #19", function() {
			
		var output, input = date_create_datetime(2011, 9, 15, 9, 43, 44);
			
		//#6 date_inc_second( 1 )
		output = date_inc_second(input, 1);
		assert_equals(date_get_second(output), 45, "date_inc_second( 1 ) incremented second for datetime");

	});
	
	addFact("date_inc_test #20", function() {
			
		var output, input = date_create_datetime(2011, 9, 15, 9, 43, 44);
			
		//#6.1 date_inc_second( -1 )
		output = date_inc_second(input, -1);
		assert_equals(date_get_second(output), 43, "date_inc_second( -1 ) incremented second for datetime");

	});
	
	addFact("date_inc_test #21", function() {
			
		var output, input = date_create_datetime(2011, 9, 15, 9, 43, 44);
			
		//#6.2 date_inc_second( 60 )
		output = date_inc_second(input, 60);
		assert_equals(date_get_second(output), 44, "date_inc_second( 60 ) overflow number of seconds");

	});
	
	addFact("date_inc_test #22", function() {
			
		var output, input = date_create_datetime(2011, 9, 15, 9, 43, 44);
			
		//#6.2 date_inc_second( 60 )
		output = date_inc_second(input, 60);
		assert_equals(date_get_minute(output), date_get_minute(input) + 1, "date_inc_second( 60 ), should go to next minute");

	});
	
	addFact("date_inc_test #23", function() {
			
		var output, input = date_create_datetime(2011, 9, 15, 9, 43, 44);
			
		//#7 date_inc_week( 1 )
		output = date_inc_week(input, 1);
		assert_equals(date_get_week(output), date_get_week(input) + 1, "date_inc_second( 1 ) incremented week for datetime");

	});
	
	addFact("date_inc_test #24", function() {
			
		var output, input = date_create_datetime(2011, 9, 15, 9, 43, 44);
			
		//#7.1 date_inc_week( -1 )
		output = date_inc_week(input, -1);
		assert_equals(date_get_week(output), date_get_week(input) - 1, "date_inc_second( -1 ) incremented week for datetime");

	});

	addFact("date_inc_test #25", function() {
			
		var output, input = date_create_datetime(2011, 9, 15, 9, 43, 44);
			
		//#7.2 date_inc_week( 52 )
		output = date_inc_week(input, 52);
		assert_equals(date_get_week(output), date_get_week(input), "date_inc_week( 52 ) overflow number of weeks");
				
	});
	
	addFact("date_inc_test #26", function() {
			
		var output, input = date_create_datetime(2011, 9, 15, 9, 43, 44);
			
		//#7.2 date_inc_week( 52 )
		output = date_inc_week(input, 52);
		assert_equals(date_get_year(output), date_get_year(input) + 1, "date_inc_week( 52 ), should go to next year");
				
	});
	
	// DATE COMPARE TESTS
	
	addFact("date_compare_test #1", function() {

		var firstDateTime = date_create_datetime(2011, 9, 15, 9, 43, 44);
		var firstDate = date_date_of(firstDateTime);
		var firstTime = date_time_of(firstDateTime);
				
		var secondDateTime = date_create_datetime(2015, 7, 1, 17, 31, 56);
		var secondDate = date_date_of(secondDateTime);
		var secondTime = date_time_of(secondDateTime);
			
		var output;
			
		//#1 date_compare_datetime ( oldest, latest )
		output = date_compare_datetime(firstDateTime, secondDateTime);
		assert_less(output, 0, "date_compare_datetime ( oldest, latest ), failed to compare two datetimes");
				
	});
	
	addFact("date_compare_test #2", function() {

		var firstDateTime = date_create_datetime(2011, 9, 15, 9, 43, 44);
		var firstDate = date_date_of(firstDateTime);
		var firstTime = date_time_of(firstDateTime);
				
		var secondDateTime = date_create_datetime(2015, 7, 1, 17, 31, 56);
		var secondDate = date_date_of(secondDateTime);
		var secondTime = date_time_of(secondDateTime);
			
		var output;
			
		//#2 date_compare_date ( oldest, latest )
		output = date_compare_date(firstDate, secondDate);
		assert_less(output, 0, "date_compare_date ( oldest, latest ), failed to compare two dates");
				
	});

	addFact("date_compare_test #3", function() {

		var firstDateTime = date_create_datetime(2011, 9, 15, 9, 43, 44);
		var firstDate = date_date_of(firstDateTime);
		var firstTime = date_time_of(firstDateTime);
				
		var secondDateTime = date_create_datetime(2015, 7, 1, 17, 31, 56);
		var secondDate = date_date_of(secondDateTime);
		var secondTime = date_time_of(secondDateTime);
			
		var output;
			
		//#3 date_compare_time ( oldest, latest )
		output = date_compare_time(firstDateTime, secondDateTime);
		assert_less(output, 0, "date_compare_time ( oldest, latest ), failed to compare two times");
			
	});
	
	// DATE SPAN TESTS
	
	addFact("date_span_test #1", function() {

		// Set an explicit epsilon to account for different default epsilons in YYC and VM.
		math_set_epsilon(0.00001);
			
		var output;
		var firstDateTime = date_create_datetime(2011, 9, 15, 9, 43, 44);	
		var secondDateTime = date_create_datetime(2015, 7, 1, 17, 31, 56);

		output = date_year_span(firstDateTime, secondDateTime);
		assert_equals(output, 3.79281352194083, "date_year_span returned the wrong year span between the datetimes");
			
	});
	
	addFact("date_span_test #2", function() {

		// Set an explicit epsilon to account for different default epsilons in YYC and VM.
		math_set_epsilon(0.00001);
			
		var output;
		var firstDateTime = date_create_datetime(2011, 9, 15, 9, 43, 44);	
		var secondDateTime = date_create_datetime(2015, 7, 1, 17, 31, 56);
			
		output = date_month_span(firstDateTime, secondDateTime);
		assert_equals(output, 45.51376226329, "date_month_span returned the wrong month span between the datetimes");
			
	});
	
	addFact("date_span_test #3", function() {

		// Set an explicit epsilon to account for different default epsilons in YYC and VM.
		math_set_epsilon(0.00001);
			
		var output;
		var firstDateTime = date_create_datetime(2011, 9, 15, 9, 43, 44);	
		var secondDateTime = date_create_datetime(2015, 7, 1, 17, 31, 56);
			
		output = date_week_span(firstDateTime, secondDateTime);
		assert_equals(output, 197.903591269841, "date_week_span returned the wrong week span between the datetimes");
			
	});
	
	addFact("date_span_test #4", function() {

		// Set an explicit epsilon to account for different default epsilons in YYC and VM.
		math_set_epsilon(0.00001);
			
		var output;
		var firstDateTime = date_create_datetime(2011, 9, 15, 9, 43, 44);	
		var secondDateTime = date_create_datetime(2015, 7, 1, 17, 31, 56);
			
		output = date_day_span(firstDateTime, secondDateTime);
		assert_equals(output, 1385.32513888889, "date_day_span returned the wrong day span between the datetimes");
			
	});
	
	addFact("date_span_test #5", function() {

		// Set an explicit epsilon to account for different default epsilons in YYC and VM.
		math_set_epsilon(0.00001);
			
		var output;
		var firstDateTime = date_create_datetime(2011, 9, 15, 9, 43, 44);	
		var secondDateTime = date_create_datetime(2015, 7, 1, 17, 31, 56);
			
		output = date_hour_span(firstDateTime, secondDateTime);
		assert_equals(output, 33247.8033333333, "date_hour_span returned the wrong hour span between the datetimes");
			
	});

	addFact("date_span_test #6", function() {

		// Set an explicit epsilon to account for different default epsilons in YYC and VM.
		math_set_epsilon(0.00001);
			
		var output;
		var firstDateTime = date_create_datetime(2011, 9, 15, 9, 43, 44);	
		var secondDateTime = date_create_datetime(2015, 7, 1, 17, 31, 56);
			
		output = date_minute_span(firstDateTime, secondDateTime);
		assert_equals(output, 1994868.2, "date_minute_span returned the wrong minute span between the datetimes");
			
	});

	addFact("date_span_test #7", function() {

		// Set an explicit epsilon to account for different default epsilons in YYC and VM.
		math_set_epsilon(0.00001);
			
		var output;
		var firstDateTime = date_create_datetime(2011, 9, 15, 9, 43, 44);	
		var secondDateTime = date_create_datetime(2015, 7, 1, 17, 31, 56);
			
		output = date_second_span(firstDateTime, secondDateTime);
		assert_equals(output, 119692092, "date_second_span returned the wrong second span between the datetimes");

	});
	
	// DATE TIMEZONE TESTS
	
	addFact("date_timezone_test #1", function() {

		var old = date_get_timezone();

		date_set_timezone(timezone_local);
		assert_equals(date_get_timezone(), timezone_local, "date_set_timezone( timezone_local ), failed to switch timezones");

		date_set_timezone(old);

	});

	addFact("date_timezone_test #2", function() {

		var old = date_get_timezone();
			
		date_set_timezone(timezone_utc);
		assert_equals(date_get_timezone(), timezone_utc, "date_set_timezone( timezone_utc ), failed to switch timezones");

		date_set_timezone(old);

	});

	// DATE & TIME (SEPERATE)
	
	addFact("date_date_of_test #1", function() {
				
		var output, input = date_create_datetime(2011, 9, 15, 9, 43, 44);
		
		input = date_date_of(input);

		output = date_get_year(input);
		assert_equals(output, 2011, "date_get_year( date ), returned the wrong value");

	});

	addFact("date_date_of_test #2", function() {
				
		var output, input = date_create_datetime(2011, 9, 15, 9, 43, 44);
		
		input = date_date_of(input);

		output = date_get_month(input);
		assert_equals(output, 9, "date_get_month( date ), returned the wrong value");

	});

	addFact("date_date_of_test #3", function() {
				
		var output, input = date_create_datetime(2011, 9, 15, 9, 43, 44);
		
		input = date_date_of(input);

		output = date_get_day(input);
		assert_equals(output, 15, "date_get_day( date ), returned the wrong value");

	});

	addFact("date_date_of_test #4", function() {
				
		var output, input = date_create_datetime(2011, 9, 15, 9, 43, 44);
		
		input = date_date_of(input);
			
		output = date_get_hour(input);
		assert_equals(output, 0, "date_get_hour( date ), should return zero (0)");

	});

	addFact("date_date_of_test #5", function() {
				
		var output, input = date_create_datetime(2011, 9, 15, 9, 43, 44);
		
		input = date_date_of(input);
			
		output = date_get_minute(input);
		assert_equals(output, 0, "date_get_minute( date ), should return zero (0)");

	});

	addFact("date_date_of_test #6", function() {
				
		var output, input = date_create_datetime(2011, 9, 15, 9, 43, 44);
		
		input = date_date_of(input);
			
		output = date_get_second(input);
		assert_equals(output, 0, "date_get_second( date ), should return zero (0)");

	});
	
	// DATE TIME OF TESTS
		
	addFact("date_time_of_test #1", function() {
				
		var output, input = date_create_datetime(2011, 9, 15, 9, 43, 44);
		
		input = date_time_of(input);

		output = date_get_year(input);
		assert_equals(output, 1970, "date_get_year( time ), should return 1970 (default year)");

	});
		
	addFact("date_time_of_test #2", function() {
				
		var output, input = date_create_datetime(2011, 9, 15, 9, 43, 44);
		
		input = date_time_of(input);

		output = date_get_month(input);
		assert_equals(output, 1, "date_get_month( time ), should return 1 (default month)");

	});
		
	addFact("date_time_of_test #3", function() {
				
		var output, input = date_create_datetime(2011, 9, 15, 9, 43, 44);
		
		input = date_time_of(input);

		output = date_get_day(input);
		assert_equals(output, 1, "date_get_day( time ), should return 1 (default day)");

	});
		
	addFact("date_time_of_test #4", function() {
				
		var output, input = date_create_datetime(2011, 9, 15, 9, 43, 44);
		
		input = date_time_of(input);
			
		output = date_get_hour(input);
		assert_equals(output, 9, "date_get_hour( time ), returned the wrong value");

	});
		
	addFact("date_time_of_test #5", function() {
				
		var output, input = date_create_datetime(2011, 9, 15, 9, 43, 44);
		
		input = date_time_of(input);
			
		output = date_get_minute(input);
		assert_equals(output, 43, "date_get_minute( time ), returned the wrong value");

	});
		
	addFact("date_time_of_test #6", function() {
				
		var output, input = date_create_datetime(2011, 9, 15, 9, 43, 44);
		
		input = date_time_of(input);
			
		output = date_get_second(input);
		assert_equals(output, 44, "date_get_second( time ), returned the wrong value");

	});

	// PLATFORM SPECIFIC

/*
	addFact("date_datetime_string_windows_html5", function() {

		var dateTime = date_create_datetime(2011, 9, 15, 9, 43, 44);
			
		var dateTimeString = "15/09/2011 09:43:44";			
		assert_equals(date_datetime_string(dateTime), dateTimeString, "date_datetime_string returned the wrong value");
				
		var dateString = "15/09/2011";
						
		assert_equals(date_date_string(dateTime), dateString, "date_date_string returned the wrong value");
		assert_equals(date_time_string(dateTime), "09:43:44", "date_time_string returned the wrong value");
			
			
	}, { test_filter: function() { return platform_windows() || platform_browser(); } });
		
	addFact("date_datetime_string_macos_ios_android", function() {
			
		var dateTime = date_create_datetime(2011, 9, 15, 9, 43, 44);
					
		var dateTimeString =  "Thu Sep 15 09:43:44 2011";
		assert_equals(date_datetime_string(dateTime), dateTimeString, "date_datetime_string returned the wrong value");
				
		var dateString = "09/15/11";	
		assert_equals(date_date_string(dateTime), dateString, "date_date_string returned the wrong value");
		assert_equals(date_time_string(dateTime), "09:43:44", "date_time_string returned the wrong value");
			
	}, { test_filter: function() { return platform_macosx() || platform_browser(); } });
*/
}
