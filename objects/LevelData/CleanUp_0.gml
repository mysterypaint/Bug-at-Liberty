/// @description Insert description here
if (ds_exists(layers, ds_type_list)) {
	var _layers_size = ds_list_size(layers);
	
	for (var _i = 0; _i < _layers_size; _i++) {
		var _this_layer = layers[| _i];
		var _this_layer_name = _this_layer[| 0];
		
		if (_this_layer_name != "Instances") {
			var _is_collision_layer = false;
			
			if (_this_layer_name == "Collision")
				_is_collision_layer = true;
			
			if (!_is_collision_layer) {
				var _lvl_data_grid = _this_layer[| 1];
				ds_grid_destroy(_lvl_data_grid);
			} else {
				if layer_tilemap_exists(collision_layer, collision_layer_tiles) {
					layer_tilemap_destroy(collision_layer_tiles);
				}
			}
		}
	}
	
	ds_list_destroy(layers);
}

if (ds_exists(instances, ds_type_list)) {
	var _num_instances = ds_list_size(instances);
	for (var _i = 0; _i < _num_instances; _i++) {
		var _this_instance = instances[| _i];
		if (instance_exists(_this_instance))
			instance_destroy(_this_instance);
	}
	
	ds_list_destroy(instances);
}

if (ds_exists(tilesets, ds_type_list)) {
	var _num_instances = ds_list_size(tilesets);
	/*
	for (var _i = 0; _i < _num_instances; _i++) {
		var _this_tileset = tilesets[| _i];
		ds_list_destroy(_this_tileset);
	}*/
	
	ds_list_destroy(tilesets);
}

if (ds_exists(tileset_gids, ds_type_list)) {
	var _num_gids = ds_list_size(tileset_gids);
	/*
	for (var _i = 0; _i < _num_gids; _i++) {
		var _this_tileset_gid = tileset_gids[| _i];
		ds_list_destroy(_this_tileset_gid);
	}*/
	
	ds_list_destroy(tileset_gids);
}