/// @description Insert description here
ds_grid_destroy(text_contents);

if (ds_exists(global.string_split_list, ds_type_list))
	ds_list_destroy(global.string_split_list);