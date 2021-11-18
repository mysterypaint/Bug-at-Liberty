/// @description Sort the depth grid
var _dgrid = ds_draw_object_depth_sort;
num_draw_objects = instance_number(ParentDraw);
		
ds_grid_resize(_dgrid, 2, num_draw_objects);
		
var _yy = 0; with (ParentDraw) {
	_dgrid[# 0, _yy] = id;
	_dgrid[# 1, _yy] = depth;
	_yy++;
}
		
ds_grid_sort(_dgrid, 1, true);