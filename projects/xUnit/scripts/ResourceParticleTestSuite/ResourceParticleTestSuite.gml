/// @ignore
function __ResourceParticleSystemTestSuiteData()
{
	static Data = 
	{
		passed:			false, 
		partinfo:		undefined,
		partinfosystem: undefined,
	};
	return Data;
}

function ResourceParticleSystemTestSuite() : TestSuite() constructor
{
	addFact("part_system_create_and_destroy_test_1", function() 
	{

		static PartResourceRef = "ref particle_system_resource ";
		static PartInstanceRef = "ref particle_system_instance ";
		
		#region Test asset reference.
		var partsystem = handle_testParticleSystem;
		var partsystemString = string(partsystem);
		assert_equals(partsystemString, PartResourceRef+"0", $"#1.0 {partsystemString} is not {PartResourceRef}");
		
		#endregion
		
		#region part_system_create()
		var ref0 = part_system_create();
		var ref0String = string(ref0);
		assert_true(part_system_exists(ref0), "#2.0 part_system_create(), failed to create a particle_system_instance");
		assert_equals(ref0String, PartInstanceRef+"0", $"#2.1 {ref0String} is not {PartInstanceRef+"0"}");
		// part_system_destroy on part_system_create()
		part_system_destroy(ref0);
		assert_false(part_system_exists(ref0), "#2.2 part_system_destroy(), failed to destroy a ParticleSystem created using part_system_create()");	
		
		#endregion
		
		#region part_system_create(Asset).
		var ref1 = part_system_create(partsystem);
		var ref1String = string(ref1);
		assert_true(part_system_exists(ref1), "#3.0 part_system_create(Asset), failed to create a ParticleSystem");
		assert_equals(ref1String, PartInstanceRef+"0", $"#3.1 {ref1String} is not {PartInstanceRef+"0"}");
		// part_system_destroy on part_system_create
		part_system_destroy(ref1);
		assert_false(part_system_exists(ref1), "#3.2 part_system_destroy, failed to destroy a ParticleSystem created using part_system_create");	
		
		#endregion
		
		#region part_system_create_layer: With layer name no persistent.
		var ref2 = part_system_create_layer("Instances", false, partsystem);
		var ref2String = string(ref2);
		assert_true(part_system_exists(ref2), "#4.0 part_system_create_layer(LayerName, false, Asset), failed to create a ParticleSystem");
		assert_equals(ref2String, PartInstanceRef+"0", $"#4.1 {ref2String} is not {PartInstanceRef+"0"}");
		// part_system_destroy on part_system_create_layer(LayerName)
		part_system_destroy(ref2);
		assert_false(part_system_exists(ref2), "#4.2 part_system_destroy, failed to destroy a ParticleSystem created using part_system_create_layer(LayerName, false, Asset)");
		
		#endregion
		
		#region part_system_create_layer: With layer id no persistent.
		var ref3 = part_system_create_layer(layer_create(0), false, partsystem);
		var ref3String = string(ref3);
		assert_true(part_system_exists(ref3), "#5.0 part_system_create_layer(LayerID, false, Asset), failed to create a ParticleSystem");		
		assert_equals(ref3String, PartInstanceRef+"0", $"#5.1 {ref3String} is not {PartInstanceRef+"0"}");
		// part_system_destroy on part_system_create_layer(LayerID)
		part_system_destroy(ref3);
		assert_false(part_system_exists(ref3), "#5.2 part_system_destroy, failed to destroy a ParticleSystem created using part_system_create_layer(LayerID, false, Asset)");		
		
		#endregion
	});

	addTestAsync("part_system_persistent", objTestAsyncRoomChange,
	{
		
		ev_create: function() {
			var partsystem = handle_testParticleSystem;
			
			#region part_system_create_layer: With layer name persistent.
			part_ref0 = part_system_create_layer("Instances", true, partsystem);
			assert_true(part_system_exists(part_ref0), "#6.0 part_system_create_layer(LayerID, true, Asset), failed to create a ParticleSystem");	
			
			#endregion
		
			#region part_system_create_layer: With layer id persistent.
			part_ref1 = part_system_create_layer(layer_create(0), true, partsystem);
			assert_true(part_system_exists(part_ref0), "#6.1 part_system_create_layer(LayerID, true, Asset), failed to create a ParticleSystem");	
		
			#endregion
		
			#region part_system_create not persistent to see it exists after a room change.
			part_ref2 = part_system_create(partsystem);
			assert_true(part_system_exists(part_ref2), "#6.2 part_system_create_layer(Asset), failed to create a ParticleSystem");	
		
			#endregion
		
			room_goto(room0);
		},
		
		ev_room_start: function() {
			
			assert_true(room == room0, "The room didn't change!");
			
			// Check if your object exists (it should if it is persistent)
			var r = room;
			
			#region Check that the persistent particle_system are still alive.
			assert_true(part_system_exists(part_ref0),  "#7.0 part_system_create_layer(LayerName, true), not exists after a room change");
			assert_true(part_system_exists(part_ref1),  "#7.1 part_system_create_layer(LayerID, true), not exists after a room change");	
			assert_false(part_system_exists(part_ref2), "#7.2 part_system_create, existing after a room change");
		
			#endregion
		
			#region part_system_destroy on part_system_create_layer(LayerName, true)
			part_system_destroy(part_ref0);
			assert_false(part_system_exists(part_ref0), "#8.1 part_system_destroy, failed to destroy a ParticleSystem created using part_system_create_layer(LayerName, true)");		
		
			#endregion
		
			#region part_system_destroy on part_system_create_layer(LayerID, true)
			part_system_destroy(part_ref1);
			assert_false(part_system_exists(part_ref1), "#8.2 part_system_destroy, failed to destroy a ParticleSystem created using part_system_create_layer(LayerID, true)");			
		
			#endregion
			
			// The test only ends when you call this
			// Be sure to call this
			test_end();
		}
	}, 
	{
		// Make sure we give this test a timeout (1 second is enough for this test)
		test_timeout_millis: 1000 
	});
	
	addFact("part_system_get_info", function()
	{
		static PartData = __ResourceParticleSystemTestSuiteData();
		
		var _system = part_system_create(handle_testParticleSystem);
		PartData.partinfo = part_system_get_info(_system);
		part_system_destroy(_system);
		
		assert_true(is_struct(PartData.partinfo),  "#1.1 part_system_get_info() is not a struct");
		assert_struct_not_empty(PartData.partinfo, "#1.2 part_system_get_info() is empty");
	})
	
	#region part_system_get_info_main
	addTheory("part_system_get_info_main",
	[
		[[
		"oldtonew",
		"global_space",
		"xorigin",
		"yorigin",
		"emitters",
		"name",
		]]
		
	], function(_input) {
		static PartData = __ResourceParticleSystemTestSuiteData();
		
		var _struct = PartData.partinfo;
		var i=0; repeat(array_length(_input) )
		{
			var _var = _input[i];
			assert_true(variable_struct_exists(_struct, _var), string("#1.0 part_system_struct {0} {1} not exists", i, _var) );
			
			i = i + 1;
		}
	});
	
	#endregion
	
	#region part_system_get_info_emitter
	addTheory("part_system_get_info_emitter",
	[
		[[
		"mode",
		"relative",
		"delay_min",
		"delay_max",
		"delay_unit",
		"interval_min",
		"interval_max",
		"interval_unit",
		
		"xmin",
		"xmax",
		
		"ymin",
		"ymax",
		
		"distribution",
		"shape",
		"enabled",
		"parttype",
		"number",
		]]
	], function(_input) {
		static PartData = __ResourceParticleSystemTestSuiteData();
		
		var _struct = PartData.partinfo;
		var _emitter = _struct.emitters[0];
		var i=0; repeat(array_length(_input) )
		{
			var _var = _input[i];
			assert_true(variable_struct_exists(_emitter, _var), string("#1.0 part_system_struct_emitter {0} {1} not exists", i, _var) );
			
			i = i + 1;
		}
	});
	
	#endregion
	
	#region part_system_get_info_parttype
	addTheory("part_system_get_info_parttype",
	[ 
		[[
		"frame",
		"stretch",
		"shape",
		"ind",
		"sprite",
		"animate",
		"random",
		
		"size_xmin",
		"size_xmax",
		
		"size_ymin",
		"size_ymax",
		
		"size_xincr",
		"size_yincr",
		
		"size_xwiggle",
		"size_ywiggle",
		
		"xscale",
		"yscale",
		
		"life_min",
		"life_max",
		
		"death_type",
		"death_number",
		
		"step_type",
		"step_number",
		
		"speed_min",
		"speed_max",
		"speed_incr",
		"speed_wiggle",
		
		"dir_min",
		"dir_max",
		"dir_incr",
		"dir_wiggle",
		
		"grav_amount",
		"grav_dir",
		
		"ang_min",
		"ang_max",
		"ang_incr",
		"ang_wiggle",
		"ang_relative",
		
		"color1", "color2", "color3",
		"alpha1", "alpha2", "alpha3",
		
		"additive"
		]]
		
	], function(_input) {
		static PartData = __ResourceParticleSystemTestSuiteData();
		
		var _struct = PartData.partinfo;
		var _parttype = _struct.emitters[0].parttype;
		var i=0; repeat(array_length(_input) )
		{
			var _var = _input[i];
			assert_true(variable_struct_exists(_parttype, _var), string("#1.0 part_system_struct_emitter_parttype {0} {1} not exists", i, _var) );
			
			i = i + 1;
		}
	});

	#endregion
}