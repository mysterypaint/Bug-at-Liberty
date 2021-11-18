// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function read_json(_fName){
	var data = "";
	var json = file_text_open_read(_fName);
	while(!file_text_eof(json))
	{
	   data += file_text_read_string(json);
	   file_text_readln(json);
	}
	file_text_close(json);

	var _result_map = json_decode(data);
	var _lvl_obj = instance_create_depth(0, 0, depth, LevelData);
	
	_lvl_obj.map_width = ds_map_find_value(_result_map, "width");
	_lvl_obj.map_height = ds_map_find_value(_result_map, "height");
	var _layer_list = ds_map_find_value(_result_map, "layers");
	var _tileset_list = ds_map_find_value(_result_map, "tilesets");
	_lvl_obj.layers = ds_list_create();
	_lvl_obj.instances = ds_list_create();
	_lvl_obj.tilesets = ds_list_create();
	_lvl_obj.tileset_gids = ds_list_create();

	_lvl_obj.collision_layer = layer_create(10000, "Collision");
	_lvl_obj.collision_layer_tiles = layer_tilemap_create(_lvl_obj.collision_layer, 0, 0, tilesheet1, _lvl_obj.map_width, _lvl_obj.map_height);
	
	// Set the background color based on the Tiled data
	var _cstr = ds_map_find_value(_result_map, "backgroundcolor");
	var _bg_color = c_black;
	if (!is_undefined(_cstr)) {
		var _bg_color_hex = string_char_at(_cstr, 6) + string_char_at(_cstr, 7) + string_char_at(_cstr, 4) + string_char_at(_cstr, 5) + string_char_at(_cstr, 2) + string_char_at(_cstr, 3);
		_bg_color = str_to_hex(_bg_color_hex);
	}
	
	var _lay_id = layer_get_id("Background");
	var _back_id = layer_background_get_id(_lay_id);
    layer_background_blend(_back_id, _bg_color);
	
	
	var _num_tilesets = ds_list_size(_tileset_list);
	
	for (var _i = 0; _i < _num_tilesets; _i++) {
		var _this_tileset = _tileset_list[| _i];
		var _firstgid = _this_tileset[? "firstgid"];
		var _source = _this_tileset[? "source"];
		var _tileset_path = string_split(_source, "/");
		var _len = array_length_1d(_tileset_path);
		var _tileset_name = string_split(_tileset_path[_len - 1], ".")[0];
		
		ds_list_add(_lvl_obj.tileset_gids, _firstgid);
		if (_tileset_name != "collision_tile")
			ds_list_add(_lvl_obj.tilesets, asset_get_index(_tileset_name));
		else
			ds_list_add(_lvl_obj.tilesets, -1);
	}


	var _num_layers = ds_list_size(_layer_list);
	
	var _map_width = _lvl_obj.map_width;
	var _map_height = _lvl_obj.map_height;
	
	for (var _i = 0; _i < _num_layers; _i++) {
		var _this_layer = ds_list_create();
			
		var _this_layer_type = ds_map_find_value(_layer_list[| _i], "type");
			
		if (_this_layer_type != "objectgroup") {
			var _name = ds_map_find_value(_layer_list[| _i], "name");
			var _this_layer_data = ds_map_find_value(_layer_list[| _i], "data");
			
			ds_list_add(_this_layer, _name);
			
			var _layer_data_buffer = buffer_base64_decode(_this_layer_data);
		
			var _tile_count = buffer_get_size(_layer_data_buffer) / 4;
		
			if (_name != "Collision")
				var _layer_grid = ds_grid_create(_map_width, _map_height);
			
			for (var _y = 0; _y < _map_height; _y++) {
				for (var _x = 0; _x < _map_width; _x++) {
					var _tileID = buffer_read(_layer_data_buffer, buffer_u32);
					
					if (_name != "Collision")
						_layer_grid[# _x, _y] = _tileID;
					else {
						var _this_tile = tilemap_get(_lvl_obj.collision_layer_tiles, _x, _y);
						_this_tile = tile_set_index(_this_tile, _tileID);
						tilemap_set(_lvl_obj.collision_layer_tiles, _this_tile, _x, _y);
					}
				}
			}
			
			buffer_delete(_layer_data_buffer);
			
			if (_name != "Collision")
				ds_list_add(_this_layer, _layer_grid);
		} else {
			// Enemy spawn data
			ds_list_add(_this_layer, "Instances");
			var _instance_spawn_list = ds_map_find_value(_layer_list[| _i], "objects");
			
			var _spawn_list_size = ds_list_size(_instance_spawn_list);
			
			for (var _j = 0; _j < _spawn_list_size; _j++) {
				var _inst_spawn_data_copy = ds_map_create();
				
				var _inst_spawn_data = _instance_spawn_list[| _j];
				var _id = _inst_spawn_data[? "id"];
				var _name = _inst_spawn_data[? "name"];
				var _x = _inst_spawn_data[? "x"];
				var _y = _inst_spawn_data[? "y"];
				var _type = _inst_spawn_data[? "type"];
				var _visible = _inst_spawn_data[? "visible"];
				var _rotation = _inst_spawn_data[? "rotation"];
				var _width = _inst_spawn_data[? "width"];
				var _height = _inst_spawn_data[? "height"];
				
				var _new_entity = level_data_spawn_entity(_id, _name, _x, _y, _type, _visible, _rotation, _width, _height); // returns the new object's ID
				ds_list_add(_lvl_obj.instances, _new_entity);
			}
			
			
		}
			
		ds_list_add(_lvl_obj.layers, _this_layer);
	}
	
	ds_map_destroy(_result_map);
	
	if (instance_exists(Camera)) {
		Camera.level_data_obj = _lvl_obj;
	}
	
	return _lvl_obj;
}