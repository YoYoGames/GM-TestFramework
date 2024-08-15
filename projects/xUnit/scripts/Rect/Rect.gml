/// @function Rect()
/// @description Represents a rectangle through it's left-most, top-most, right-most, and bottom-most values
/// @param {Real} left left-most value of the rectangle (x coordinate of the top-left point)
/// @param {Real} top top-most value of the rectangle (y coordinate of the top-left point)
/// @param {Real} right right-most value of the rectangle (x coordinate of the bottom-right point)
/// @param {Real} bottom bottom-most value of the rectangle (y coordinate of the bottom-right point)
function Rect(_left = 0, _top = 0, _right = 0, _bottom = 0) constructor {
	left = _left;
	top = _top;
	right = _right;
	bottom = _bottom;
}