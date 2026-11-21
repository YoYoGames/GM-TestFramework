// feather ignore GM1041
// Tests for view_set_viewport, the experimental non-rectangular viewports (GMS2-Runner-Main#1076).
//
// Each drawing test turns view 0 into a full-size view with its own camera, gives it an L-shaped polygon,
// fills the view with red in its Draw event, and then reads back pixels inside the L, in the corner cut out of
// it, and outside it. The view's port covers the whole application surface, so the polygon's points are
// pixels on the application surface (or the screen).

// L-shaped (concave) polygon: a 64x64 square at (100,80) with its top-right 32x32 quarter cut out
#macro VSV_POLYGON [100,80, 132,80, 132,112, 164,112, 164,144, 100,144]

function BasicViewSetViewportTestSuite() : TestSuite() constructor {

	addTestAsync("view_set_viewport draws a polygon on the application surface", objTestAsyncViewport, {

		ev_create: function() {
			frames = 0;
			startCalls = 0;
			endCalls = 0;
			width = surface_get_width(application_surface);
			height = surface_get_height(application_surface);
			vsv_setup(self, width, height);

			view_set_viewport([ {
				polygons: VSV_POLYGON,
				screenX: 0, screenY: 0, screenW: width, screenH: height,
				roomRectX: 0, roomRectY: 0, roomRectW: width, roomRectH: height,
				startFunc: method(self, function() { startCalls++; }),
				endFunc: method(self, function() { endCalls++; }),
			} ]);

			// the view had no surface, so one is created for it
			assert_not_equals(view_get_surface_id(0), -1, "view_set_viewport(), didn't create a surface for the view");
		},

		ev_draw: function() {
			if (view_current == 0) draw_clear(c_red);
		},

		ev_step: function() {
			// the application surface holds the last frame, so give it a couple of frames to be drawn
			if (++frames < 3) return;

			vsv_assert_pixels(function(_x, _y) { return surface_getpixel(application_surface, _x, _y); }, "application surface");
			assert_true(startCalls > 0, "view_set_viewport(), startFunc wasn't called");
			assert_true(endCalls > 0, "view_set_viewport(), endFunc wasn't called");
			assert_equals(startCalls, endCalls, "view_set_viewport(), startFunc and endFunc weren't called the same number of times");

			// an empty polygons array turns the polygon off and frees the surface that was created for it
			view_set_viewport([ { polygons: [] } ]);
			assert_equals(view_get_surface_id(0), -1, "view_set_viewport(), polygons : [] didn't free the view's surface");

			test_end();
		},

		ev_cleanup: function() {
			vsv_restore(self);
		}

	}, {
		test_filter: platform_view_set_viewport,
		test_timeout_millis: 5000,
	});

	addTestAsync("view_set_viewport draws a polygon on the screen without an application surface", objTestAsyncViewport, {

		ev_create: function() {
			frames = 0;
			width = surface_get_width(application_surface);
			height = surface_get_height(application_surface);
			application_surface_enable(false);
			vsv_setup(self, width, height);

			// the viewports can also be given as JSON
			view_set_viewport(json_stringify([ {
				polygons: VSV_POLYGON,
				screenX: 0, screenY: 0, screenW: width, screenH: height,
				roomRectX: 0, roomRectY: 0, roomRectW: width, roomRectH: height,
			} ]));
		},

		ev_draw: function() {
			if (view_current == 0) draw_clear(c_red);
		},

		ev_step: function() {
			++frames;
		},

		ev_draw_post: function() {
			// application_surface_enable takes effect on the next frame
			if (frames < 3) return;

			assert_false(application_surface_is_enabled(), "application_surface_enable(), didn't turn the application surface off");
			vsv_assert_pixels(function(_x, _y) { return draw_getpixel(_x, _y); }, "screen");

			test_end();
		},

		ev_cleanup: function() {
			application_surface_enable(true);
			vsv_restore(self);
		}

	}, {
		test_filter: platform_view_set_viewport,
		test_timeout_millis: 5000,
	});

	addFact("view_set_viewport errors", function() {

		assert_throw(function() {
			view_set_viewport(5);
		}, "view_set_viewport(), didn't throw for an argument that isn't an array or a string");

		assert_throw(function() {
			view_set_viewport("not json");
		}, "view_set_viewport(), didn't throw for a string that isn't JSON");

		assert_throw(function() {
			view_set_viewport("{ \"polygons\" : [] }");
		}, "view_set_viewport(), didn't throw for JSON that isn't an array");

		assert_throw(function() {
			view_set_viewport(array_create(9, {}));
		}, "view_set_viewport(), didn't throw for more than 8 viewports");

		assert_throw(function() {
			view_set_viewport([ 5 ]);
		}, "view_set_viewport(), didn't throw for an entry that isn't a struct");

		assert_throw(function() {
			view_set_viewport([ { polygons: 5 } ]);
		}, "view_set_viewport(), didn't throw for polygons that isn't an array");

		// turning off a polygon that was never set does nothing
		view_set_viewport([ { polygons: [] } ]);
		assert_equals(view_get_surface_id(0), -1, "view_set_viewport(), polygons : [] gave view 0 a surface");

	}, {
		test_filter: platform_view_set_viewport,
	});

}

/// @function platform_view_set_viewport()
/// @description view_set_viewport is only in the C++ runner (VM and YYC), not HTML5 or GMRT.
function platform_view_set_viewport() {
	return platform_not_browser() && runtime_not_gmrt();
}

/// @function vsv_setup(state, width, height)
/// @description Saves view 0 into state, then makes it a visible width x height view with its own camera.
function vsv_setup(_state, _width, _height) {
	_state.savedView = {
		enabled: view_enabled,
		visible: view_get_visible(0),
		camera: view_get_camera(0),
		xport: view_get_xport(0),
		yport: view_get_yport(0),
		wport: view_get_wport(0),
		hport: view_get_hport(0),
	};
	_state.camera = camera_create_view(0, 0, _width, _height);
	view_set_camera(0, _state.camera);
	view_enabled = true;
	view_set_visible(0, true);
}

/// @function vsv_restore(state)
/// @description Turns view 0's polygon off and puts view 0 back as vsv_setup found it.
function vsv_restore(_state) {
	view_set_viewport([ { polygons: [] } ]);

	var _saved = _state.savedView;
	view_set_camera(0, _saved.camera);
	view_set_xport(0, _saved.xport);
	view_set_yport(0, _saved.yport);
	view_set_wport(0, _saved.wport);
	view_set_hport(0, _saved.hport);
	view_set_visible(0, _saved.visible);
	view_enabled = _saved.enabled;
	camera_destroy(_state.camera);
}

/// @function vsv_assert_pixels(getPixel, where)
/// @description Checks that VSV_POLYGON was drawn in red: inside the L, but not in its cut-out corner or outside it.
function vsv_assert_pixels(_getPixel, _where) {
	assert_equals(_getPixel(110, 90), c_red, "view_set_viewport(), the top of the L isn't drawn on the " + _where);
	assert_equals(_getPixel(110, 134), c_red, "view_set_viewport(), the corner of the L isn't drawn on the " + _where);
	assert_equals(_getPixel(154, 134), c_red, "view_set_viewport(), the right of the L isn't drawn on the " + _where);
	assert_not_equals(_getPixel(154, 90), c_red, "view_set_viewport(), the corner cut out of the L is drawn on the " + _where);
	assert_not_equals(_getPixel(50, 50), c_red, "view_set_viewport(), outside the polygon is drawn on the " + _where);
	assert_not_equals(_getPixel(300, 300), c_red, "view_set_viewport(), outside the polygon is drawn on the " + _where);
}
