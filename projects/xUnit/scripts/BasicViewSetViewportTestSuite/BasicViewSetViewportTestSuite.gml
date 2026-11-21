// feather ignore GM1041
// Tests for view_set_viewport, the experimental non-rectangular viewports (GMS2-Runner-Main#1076).
//
// Each drawing test gives a view its own camera and an L-shaped polygon, fills the view with red in its Draw
// event, and then reads back pixels inside the L, in the corner cut out of it, and outside it. The polygon's
// points are relative to the view's port, and each port is drawn 1:1 onto the application surface (or the
// screen), so a point's pixel is the port's position plus the point.

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

	addTestAsync("view_set_viewport keeps the fields a later call leaves out", objTestAsyncViewport, {

		ev_create: function() {
			frames = 0;
			startCalls = 0;
			endCalls = 0;
			width = surface_get_width(application_surface);
			height = surface_get_height(application_surface);

			// View 0 covers the whole application surface, so moving view 1's port doesn't change the display scale.
			// The polygon is on view 1, which is drawn after view 0.
			vsv_setup(self, width, height, 0);
			vsv_setup(self, width - 16, height - 8, 1);

			view_set_viewport([ {}, {
				polygons: [0,0, 32,0, 0,32],
				screenX: 0, screenY: 0, screenW: width - 16, screenH: height - 8,
				roomRectX: 0, roomRectY: 0, roomRectW: width - 16, roomRectH: height - 8,
				startFunc: method(self, function() { startCalls++; }),
				endFunc: method(self, function() { endCalls++; }),
			} ]);
			surface = view_get_surface_id(1);
			assert_not_equals(surface, -1, "view_set_viewport(), didn't create a surface for view 1");
			assert_equals(view_get_surface_id(0), -1, "view_set_viewport(), an empty struct gave view 0 a surface");

			// a new polygon on its own keeps the surface and the callbacks
			view_set_viewport([ {}, { polygons: VSV_POLYGON } ]);
			assert_equals(view_get_surface_id(1), surface, "view_set_viewport(), a new polygon on its own changed the view's surface");
			assert_true(surface_exists(surface), "view_set_viewport(), a new polygon on its own freed the view's surface");

			// moving the port on its own moves the polygon with it, and keeps the surface
			view_set_viewport([ {}, { screenX: 16, screenY: 8 } ]);
			assert_equals(view_get_xport(1), 16, "view_set_viewport(), screenX didn't move the port");
			assert_equals(view_get_yport(1), 8, "view_set_viewport(), screenY didn't move the port");
			assert_equals(view_get_surface_id(1), surface, "view_set_viewport(), moving the port changed the view's surface");
		},

		ev_draw: function() {
			if (view_current == 1) draw_clear(c_red);
		},

		ev_step: function() {
			if (++frames < 3) return;

			vsv_assert_pixels(function(_x, _y) { return surface_getpixel(application_surface, _x, _y); }, "application surface after moving the port", 16, 8);
			assert_true(startCalls > 0, "view_set_viewport(), a later call without startFunc dropped it");
			assert_true(endCalls > 0, "view_set_viewport(), a later call without endFunc dropped it");

			test_end();
		},

		ev_cleanup: function() {
			vsv_restore(self);
		}

	}, {
		test_filter: platform_view_set_viewport,
		test_timeout_millis: 5000,
	});

	addTestAsync("view_set_viewport keeps its surface the port's size", objTestAsyncViewport, {

		ev_create: function() {
			frames = 0;
			width = surface_get_width(application_surface);
			height = surface_get_height(application_surface);
			vsv_setup(self, width, height);

			view_set_viewport([ {
				polygons: VSV_POLYGON,
				screenX: 0, screenY: 0, screenW: width, screenH: height,
				roomRectX: 0, roomRectY: 0, roomRectW: width, roomRectH: height,
			} ]);

			// resizing the port another way resizes the surface view_set_viewport created, before the view is next drawn
			view_set_wport(0, width div 2);
			view_set_hport(0, height div 2);
		},

		ev_draw: function() {
			if (view_current == 0) draw_clear(c_red);
		},

		ev_step: function() {
			++frames;
			if (frames == 2) {
				var _surface = view_get_surface_id(0);
				assert_true(_surface != -1 && surface_exists(_surface), "view_set_viewport(), the view lost its surface when the port was resized");
				if (_surface != -1 && surface_exists(_surface)) {
					assert_equals(surface_get_width(_surface), width div 2, "view_set_viewport(), the surface wasn't resized with view_set_wport");
					assert_equals(surface_get_height(_surface), height div 2, "view_set_viewport(), the surface wasn't resized with view_set_hport");

					// a lost surface (as after a device reset) is recreated
					surface_free(_surface);
				}
			}
			else if (frames == 4) {
				var _surface = view_get_surface_id(0);
				assert_true(_surface != -1 && surface_exists(_surface), "view_set_viewport(), the surface wasn't recreated after it was lost");
				if (_surface != -1 && surface_exists(_surface)) {
					assert_equals(surface_get_width(_surface), width div 2, "view_set_viewport(), the recreated surface isn't the port's width");
				}
				test_end();
			}
		},

		ev_cleanup: function() {
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

		assert_throw(function() {
			view_set_viewport([ { screenW: 0 } ]);
		}, "view_set_viewport(), didn't throw for a screenW that isn't positive");

		assert_throw(function() {
			view_set_viewport([ { roomRectH: -1 } ]);
		}, "view_set_viewport(), didn't throw for a roomRectH that isn't positive");

		assert_throw(function() {
			view_set_viewport([ { polygons: [0,80, 0,90, 30,90, 70,20, 90,80] } ]);
		}, "view_set_viewport(), didn't throw for a polygon whose closing edge crosses another edge");

		assert_throw(function() {
			view_set_viewport([ { polygons: [0,0, 32,32, 32,0, 0,32] } ]);
		}, "view_set_viewport(), didn't throw for a polygon that crosses itself");

		// a small polygon far from the origin is accepted (the area check mustn't lose precision there)
		var _error = undefined;
		try {
			view_set_viewport([ { polygons: [3000.3,2000.7, 3020.3,2000.7, 3020.3,2020.7, 3000.3,2020.7] } ]);
		} catch (_e) {
			_error = _e;
		}
		view_set_viewport([ { polygons: [] } ]);
		assert_true(is_undefined(_error), "view_set_viewport(), rejected a 20x20 square far from the origin");

		// turning off a polygon that was never set does nothing
		view_set_viewport([ { polygons: [] } ]);
		assert_equals(view_get_surface_id(0), -1, "view_set_viewport(), polygons : [] gave view 0 a surface");

	}, {
		test_filter: platform_view_set_viewport,
	});

}

/// @function platform_view_set_viewport()
/// @description view_set_viewport is in the C++ runner (VM and YYC), GMRT and HTML5.
function platform_view_set_viewport() {
	return true;
}

/// @function vsv_setup(state, width, height, [view])
/// @description Saves the view into state, then makes it a visible width x height view at (0,0) with its own camera.
function vsv_setup(_state, _width, _height, _view = 0) {
	if (!struct_exists(_state, "savedViews")) {
		_state.savedViews = [];
		_state.savedEnabled = view_enabled;
	}
	array_push(_state.savedViews, {
		view: _view,
		visible: view_get_visible(_view),
		camera: view_get_camera(_view),
		xport: view_get_xport(_view),
		yport: view_get_yport(_view),
		wport: view_get_wport(_view),
		hport: view_get_hport(_view),
		newCamera: camera_create_view(0, 0, _width, _height),
	});
	var _saved = array_last(_state.savedViews);
	view_set_camera(_view, _saved.newCamera);
	view_set_xport(_view, 0);
	view_set_yport(_view, 0);
	view_set_wport(_view, _width);
	view_set_hport(_view, _height);
	view_enabled = true;
	view_set_visible(_view, true);
}

/// @function vsv_restore(state)
/// @description Turns the polygons off and puts the views back as vsv_setup found them.
function vsv_restore(_state) {
	view_set_viewport([ { polygons: [] }, { polygons: [] } ]);

	for (var _i = array_length(_state.savedViews) - 1; _i >= 0; --_i) {
		var _saved = _state.savedViews[_i];
		var _view = _saved.view;
		view_set_camera(_view, _saved.camera);
		view_set_xport(_view, _saved.xport);
		view_set_yport(_view, _saved.yport);
		view_set_wport(_view, _saved.wport);
		view_set_hport(_view, _saved.hport);
		view_set_visible(_view, _saved.visible);
		camera_destroy(_saved.newCamera);
	}
	view_enabled = _state.savedEnabled;
}

/// @function vsv_assert_pixels(getPixel, where, [dx], [dy])
/// @description Checks that VSV_POLYGON, moved by (dx, dy), was drawn in red: inside the L, but not in its cut-out corner or outside it.
function vsv_assert_pixels(_getPixel, _where, _dx = 0, _dy = 0) {
	assert_equals(_getPixel(_dx + 110, _dy + 90), c_red, "view_set_viewport(), the top of the L isn't drawn on the " + _where);
	assert_equals(_getPixel(_dx + 110, _dy + 134), c_red, "view_set_viewport(), the corner of the L isn't drawn on the " + _where);
	assert_equals(_getPixel(_dx + 154, _dy + 134), c_red, "view_set_viewport(), the right of the L isn't drawn on the " + _where);
	assert_not_equals(_getPixel(_dx + 154, _dy + 90), c_red, "view_set_viewport(), the corner cut out of the L is drawn on the " + _where);
	assert_not_equals(_getPixel(_dx + 50, _dy + 50), c_red, "view_set_viewport(), outside the polygon is drawn on the " + _where);
	assert_not_equals(_getPixel(_dx + 300, _dy + 300), c_red, "view_set_viewport(), outside the polygon is drawn on the " + _where);
}
