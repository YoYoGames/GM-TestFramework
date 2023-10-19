

function BasicDateTimeTestSuite() : TestSuite() constructor {

	// DATETIME

	addFact("date_create_datetime_test", function() {
		
		var _value = date_create_datetime(2011, 9, 15, 9, 43, 44);
			
		//#1 typeof ( datetime )
		assert_typeof(_value, "number", "#1 typeof ( datetime ), should of type numeric");
			
		//#2 typeof ( datetime )
		assert_not_undefined(_value, "#2 datetime should not be undefined");

		//#3 typeof ( datetime )
		assert_not_null(_value, "#3 datetime should not be null");
		
	});
		
	addFact("date_current_datetime_test", function() {
		
		var value = date_current_datetime();
			
		//#1 typeof ( current_datetime )
		assert_typeof(value, "number", "#1 typeof ( current_datetime ), should of type numeric");
			
		//#2 typeof ( current_datetime )
		assert_not_undefined(value, "#2 current_datetime should not be undefined");

		//#3 typeof ( current_datetime )
		assert_not_null(value, "#3 current_datetime should not be null");
		
	});
		
	addFact("date_get_test", function() {

		var output, input = date_create_datetime(2011, 9, 15, 9, 43, 44);
			
		//#1 date_get_year( datetime )
		output = date_get_year(input);
		assert_equals(output, 2011, "#1 date_get_year( datetime ), returned the wrong value");
			
		//#2 date_get_month( datetime )
		output = date_get_month(input);
		assert_equals(output, 9, "#2 date_get_month( datetime ), returned the wrong value");
			
		//#3 date_get_day( datetime )
		output = date_get_day(input);
		assert_equals(output, 15, "#3 date_get_day( datetime ), returned the wrong value");
			
		//#4 date_get_hour( datetime )
		output = date_get_hour(input);
		assert_equals(output, 9, "#4 date_get_hour( datetime ), returned the wrong value");
			
		//#5 date_get_minute( datetime )
		output = date_get_minute(input);
		assert_equals(output, 43, "#5 date_get_minute( datetime ), returned the wrong value");
			
		//#6 date_get_second( datetime )
		output = date_get_second(input);
		assert_equals(output, 44, "#6 date_get_second( datetime ), returned the wrong value");
			
		//#7 date_get_week( datetime )
		output = date_get_week(input);
		assert_equals(output, 36, "#7 date_get_week( datetime ), returned the wrong value");
			
		//#8 date_get_weekday( datetime )
		output = date_get_weekday(input);
		assert_equals(output, 4, "#8 date_get_weekday( datetime ), returned the wrong value");
			
		//#9 date_get_day_of_year( datetime )
		output = date_get_day_of_year(input);
		assert_equals(output, 258, "#9 date_get_day_of_year( datetime ), returned the wrong value");
			
		//#10 date_get_hour_of_year( datetime )
		output = date_get_hour_of_year(input);
		assert_equals(output, 6177, "#10 date_get_hour_of_year( datetime ), returned the wrong value");
			
		//#11 date_get_minute_of_year( datetime )
		output = date_get_minute_of_year(input);
		assert_equals(output, 370663, "#11 date_get_minute_of_year( datetime ), returned the wrong value");
			
		//#12 date_get_second_of_year( datetime )
		output = date_get_second_of_year(input);
		assert_equals(output, 22239824, "#12 date_get_second_of_year( datetime ), returned the wrong value");
			
		//#13 date_is_today( datetime )
		output = date_is_today(input);
		assert_false(output, "#13 date_is_today( datetime ), returned the wrong value");
			
		//#14 date_leap_year( datetime )
		output = date_leap_year(input);
		assert_false(output, "#14 date_leap_year( datetime ), returned the wrong value");
			
		//#15 date_days_in_month( datetime )
		output = date_days_in_month(input);
		assert_equals(output, 30, "#15 date_days_in_month( datetime ), returned the wrong value");
			
		//#16 date_days_in_year( datetime )
		output = date_days_in_year(input);
		assert_equals(output, 365, "#16 date_days_in_year( datetime ), returned the wrong value");

	})

	addFact("date_inc_test", function() {
			
		var output, input = date_create_datetime(2011, 9, 15, 9, 43, 44);

		//#1 date_inc_day( 1 )
		output = date_inc_day(input, 1);
		assert_equals(date_get_day(output), 16, "#1 date_inc_day( 1 ) incremented day for datetime");
			
		//#1.1 date_inc_day( -1 )
		output = date_inc_day(input, -1);
		assert_equals(date_get_day(output), 14, "#1.1 date_inc_day( -1 ) incremented day for datetime");
			
		//#1.2 date_inc_day( 20 )
		output = date_inc_day(input, 20);
		assert_equals(date_get_day(output), 5, "#1.2 date_inc_day( 20 ), overflow number of days");
		assert_equals(date_get_month(output), date_get_month(input) + 1, "#1.2.1 date_inc_day( 20 ), should go to next month");
			
			
			
		//#2 date_inc_month( 1 )
		output = date_inc_month(input, 1);
		assert_equals(date_get_month(output), 10, "#2 date_inc_month( 1 ) incremented month for datetime");
			
		//#2.1 date_inc_month( -1 )
		output = date_inc_month(input, -1);
		assert_equals(date_get_month(output), 8, "#2.1 date_inc_month( -1 ) incremented month for datetime");
			
		//#2.2 date_inc_month( 11 )
		output = date_inc_month(input, 11);
		assert_equals(date_get_month(output), 8, "#2.2 date_inc_month( 11 ) overflow number of months");
		assert_equals(date_get_year(output), date_get_year(input) + 1, "#2.2.1 date_inc_month( 11 ), should go to next year");
			
			
			
		//#3 date_inc_year( 1 )
		output = date_inc_year(input, 1);
		assert_equals(date_get_year(output), 2012, "#3 date_inc_year( 1 ) incremented year for datetime");
			
		//#3.1 date_inc_year( -1 )
		output = date_inc_year(input, -1);
		assert_equals(date_get_year(output), 2010, "#3.1 date_inc_year( -1 ) incremented year for datetime");
			
			
			
		//#4 date_inc_hour( 1 )
		output = date_inc_hour(input, 1);
		assert_equals(date_get_hour(output), 10, "#4 date_inc_hour( 1 ) incremented hour for datetime");
			
		//#4.1 date_inc_hour( -1 )
		output = date_inc_hour(input, -1);
		assert_equals(date_get_hour(output), 8, "#4.1 date_inc_hour( -1 ) incremented hour for datetime");
			
		//#4.2 date_inc_hour( 30 )
		output = date_inc_hour(input, 30);
		assert_equals(date_get_hour(output), 15, "#4.2 date_inc_hour( 30 ) overflow number of hours");
		assert_equals(date_get_day(output), date_get_day(input) + 1, "#4.2.1 date_inc_hour( 30 ), should go to next day");
			
			
			
		//#5 date_inc_minute( 1 )
		output = date_inc_minute(input, 1);
		assert_equals(date_get_minute(output), 44, "#5 date_inc_minute( 1 ) incremented minute for datetime");
			
		//#5.1 date_inc_minute( -1 )
		output = date_inc_minute(input, -1);
		assert_equals(date_get_minute(output), 42, "#5.1 date_inc_minute( -1 ) incremented minute for datetime");
			
		//#5.2 date_get_minute( 17 )
		output = date_inc_minute(input, 17);
		assert_equals(date_get_minute(output), 0, "#5.2 date_inc_minute( 17 ) overflow number of nimutes");
		assert_equals(date_get_hour(output), date_get_hour(input) + 1, "#5.2.1 date_inc_minute( 17 ), should go to next hour");
			
			
			
		//#6 date_inc_second( 1 )
		output = date_inc_second(input, 1);
		assert_equals(date_get_second(output), 45, "#6 date_inc_second( 1 ) incremented second for datetime");
			
		//#6.1 date_inc_second( -1 )
		output = date_inc_second(input, -1);
		assert_equals(date_get_second(output), 43, "#6.1 date_inc_second( -1 ) incremented second for datetime");
			
		//#6.2 date_inc_second( 60 )
		output = date_inc_second(input, 60);
		assert_equals(date_get_second(output), 44, "#6.2 date_inc_second( 60 ) overflow number of seconds");
		assert_equals(date_get_minute(output), date_get_minute(input) + 1, "#6.2.1 date_inc_second( 60 ), should go to next minute");
			
			
			
			
		var week = date_get_week(input);
			
		//#7 date_inc_week( 1 )
		output = date_inc_week(input, 1);
		assert_equals(date_get_week(output), week + 1, "#6 date_inc_second( 1 ) incremented week for datetime");
			
		//#7.1 date_inc_week( -1 )
		output = date_inc_week(input, -1);
		assert_equals(date_get_week(output), week - 1, "#6.1 date_inc_second( -1 ) incremented week for datetime");
			
		//#7.2 date_inc_week( 52 )
		output = date_inc_week(input, 52);
		assert_equals(date_get_week(output), week, "#6.2 date_inc_week( 52 ) overflow number of weeks");
		assert_equals(date_get_year(output), date_get_year(input) + 1, "#6.2.1 date_inc_week( 52 ), should go to next year");
				
	})

	addFact("date_compare_test", function() {

		var firstDateTime = date_create_datetime(2011, 9, 15, 9, 43, 44);
		var firstDate = date_date_of(firstDateTime);
		var firstTime = date_time_of(firstDateTime);
				
		var secondDateTime = date_create_datetime(2015, 7, 1, 17, 31, 56);
		var secondDate = date_date_of(secondDateTime);
		var secondTime = date_time_of(secondDateTime);
			
		var output;
			
		//#1 date_compare_datetime ( oldest, latest )
		output = date_compare_datetime(firstDateTime, secondDateTime);
		assert_less(output, 0, "#1 date_compare_datetime ( oldest, latest ), failed to compare two datetimes");
			
		//#2 date_compare_date ( oldest, latest )
		output = date_compare_date(firstDate, secondDate);
		assert_less(output, 0, "#2 date_compare_date ( oldest, latest ), failed to compare two dates");
			
		//#3 date_compare_time ( oldest, latest )
		output = date_compare_time(firstDateTime, secondDateTime);
		assert_less(output, 0, "#3 date_compare_time ( oldest, latest ), failed to compare two times");
			
	})

	addFact("date_span_test", function() {

		// Set an explicit epsilon to account for different default epsilons in YYC and VM.
		math_set_epsilon(0.00001)
			
		var output;
		var firstDateTime = date_create_datetime(2011, 9, 15, 9, 43, 44);	
		var secondDateTime = date_create_datetime(2015, 7, 1, 17, 31, 56);

		output = date_year_span(firstDateTime, secondDateTime);
		assert_equals(output, 3.79281352194083, "#1 date_year_span returned the wrong year span between the datetimes");
			
		output = date_month_span(firstDateTime, secondDateTime);
		assert_equals(output, 45.51376226329, "#2 date_month_span returned the wrong month span between the datetimes");
			
		output = date_week_span(firstDateTime, secondDateTime);
		assert_equals(output, 197.903591269841, "#3 date_week_span returned the wrong week span between the datetimes");
			
		output = date_day_span(firstDateTime, secondDateTime);
		assert_equals(output, 1385.32513888889, "#4 date_day_span returned the wrong day span between the datetimes");
			
		output = date_hour_span(firstDateTime, secondDateTime);
		assert_equals(output, 33247.8033333333, "#5 date_hour_span returned the wrong hour span between the datetimes");
			
		output = date_minute_span(firstDateTime, secondDateTime);
		assert_equals(output, 1994868.2, "#6 date_minute_span returned the wrong minute span between the datetimes");
			
		output = date_second_span(firstDateTime, secondDateTime);
		assert_equals(output, 119692092, "#7 date_second_span returned the wrong second span between the datetimes");

	})

	addFact("date_timezone_test", function() {

		var old = date_get_timezone();

		date_set_timezone(timezone_local);
		assert_equals(date_get_timezone(), timezone_local, "#1 date_set_timezone( timezone_local ), failed to switch timezones");
			
		date_set_timezone(timezone_utc);
		assert_equals(date_get_timezone(), timezone_utc, "#2 date_set_timezone( timezone_utc ), failed to switch timezones");

		date_set_timezone(old);

	})

	// DATE & TIME (SEPERATE)

	addFact("date_date_of_test", function() {
				
		var output, input = date_create_datetime(2011, 9, 15, 9, 43, 44);
		
		input = date_date_of(input);

		output = date_get_year(input);
		assert_equals(output, 2011, "#1 date_get_year( date ), returned the wrong value");

		output = date_get_month(input);
		assert_equals(output, 9, "#2 date_get_month( date ), returned the wrong value");

		output = date_get_day(input);
		assert_equals(output, 15, "#3 date_get_day( date ), returned the wrong value");
			
		output = date_get_hour(input);
		assert_equals(output, 0, "#4 date_get_hour( date ), should return zero (0)");
			
		output = date_get_minute(input);
		assert_equals(output, 0, "#5 date_get_minute( date ), should return zero (0)");
			
		output = date_get_second(input);
		assert_equals(output, 0, "#6 date_get_second( date ), should return zero (0)");

	})
		
	addFact("date_time_of_test", function() {
				
		var output, input = date_create_datetime(2011, 9, 15, 9, 43, 44);
		
		input = date_time_of(input);

		output = date_get_year(input);
		assert_equals(output, 1970, "#1 date_get_year( time ), should return 1970 (default year)");

		output = date_get_month(input);
		assert_equals(output, 1, "#2 date_get_month( time ), should return 1 (default month)");

		output = date_get_day(input);
		assert_equals(output, 1, "#3 date_get_day( time ), should return 1 (default day)");
			
		output = date_get_hour(input);
		assert_equals(output, 9, "#4 date_get_hour( time ), returned the wrong value");
			
		output = date_get_minute(input);
		assert_equals(output, 43, "#5 date_get_minute( time ), returned the wrong value");
			
		output = date_get_second(input);
		assert_equals(output, 44, "#6 date_get_second( time ), returned the wrong value");

	})

	// PLATFORM SPECIFIC

	//addFact("date_datetime_string_windows_html5", function() {
	//
	//	var dateTime = date_create_datetime(2011, 9, 15, 9, 43, 44);
	//		
	//	var dateTimeString = "15/09/2011 09:43:44";			
	//	assert_equals(date_datetime_string(dateTime), dateTimeString, "date_datetime_string returned the wrong value");
	//			
	//	var dateString = "15/09/2011";
	//					
	//	assert_equals(date_date_string(dateTime), dateString, "date_date_string returned the wrong value");
	//	assert_equals(date_time_string(dateTime), "09:43:44", "date_time_string returned the wrong value");
	//		
	//		
	//}, { test_filter: function() { return platform_windows() || platform_browser(); } });
	//	
	//addFact("date_datetime_string_macos_ios_android", function() {
	//		
	//	var dateTime = date_create_datetime(2011, 9, 15, 9, 43, 44);
	//				
	//	var dateTimeString =  "Thu Sep 15 09:43:44 2011";
	//	assert_equals(date_datetime_string(dateTime), dateTimeString, "date_datetime_string returned the wrong value");
	//			
	//	var dateString = "09/15/11";	
	//	assert_equals(date_date_string(dateTime), dateString, "date_date_string returned the wrong value");
	//	assert_equals(date_time_string(dateTime), "09:43:44", "date_time_string returned the wrong value");
	//		
	//}, { test_filter: function() { return platform_macosx() || platform_browser(); } });

}
