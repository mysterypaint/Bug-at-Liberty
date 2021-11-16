/// @function text_contents_add(portrait_index, name, text, next_proceed_value)
/// @param {real} portrait_index The sprPortrait image index to display (-1 by default, which would be OFF)
/// @param {string} name The name to display
/// @param {string} text The dialogue to display
/// @param {real} next_proceed_value How long this piece of dialogue should be displayed for

function text_contents_add(_portrait_index, _name, _text, _next_proceed_value) {
	
	var _ds = text_contents;
	var _height = ds_grid_height(_ds);
	
	ds_grid_resize(_ds, 4, _height + 1);
	
	_ds[# 0, _height] = _portrait_index;
	_ds[# 1, _height] = _name;
	_ds[# 2, _height] = _text;
	_ds[# 3, _height] = _next_proceed_value;
}