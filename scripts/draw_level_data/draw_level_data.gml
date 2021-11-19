// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function draw_level_data(_level_data_grid, _is_collision_layer) {
	var _ts = Game.TILE_SIZE;
	// Only draw the tiles that are within camera bounds
	var _tx_start = floor((Camera.x - _ts) / _ts);
	var _tx_end = floor((Camera.x + Game.base_res_width + _ts) / _ts);
	var _ty_start = floor((Camera.y - _ts) / _ts);
	var _ty_end = floor((Camera.y + Game.base_res_height + _ts) / _ts);
	var _map_height = LevelData.map_height;
	var _map_width = LevelData.map_width;
	
	if (instance_exists(level_data_obj)) {
		var _gids = level_data_obj.tileset_gids;
		var _num_gids = ds_list_size(_gids);
		var _ds_tilesets = level_data_obj.tilesets;
		var _col_layer_tiles = LevelData.collision_layer_tiles;
		var _debug_enabled = Game.debug;
		
		for (var _y = _ty_start; _y <= _ty_end; _y++) {
			for (var _x = _tx_start; _x < _tx_end; _x++) {
				if (_y < 0 || _x < 0 || _y >= _map_height || _x >= _map_width)
					continue;
				//var _tileID = level_data_obj.tilesets[| 1];
				
				
				if (!_is_collision_layer) {
					var _tileID = _level_data_grid[# _x, _y];
					var _tileset = -1;
					var _min_difference = 99999;
					var _finalTileID = -1;
					
					for (var _i = 0; _i < _num_gids; _i++) {
				        if (_gids[| _i] <= _tileID && _tileID - _gids[| _i] < _min_difference)
				        {
				            _tileset = _ds_tilesets[| _i];
				            _min_difference = _tileID - _gids[| _i];
							_finalTileID = _tileID - _gids[| _i];
				        }
					}
	
				
					if (_tileset >= 0 && !is_undefined(_tileID)) {
						var _ts_width = floor(sprite_get_width(_tileset) / _ts);
						var _tspx_left = floor((_finalTileID) % _ts_width) * _ts;
						var _tspx_top = floor((_finalTileID) / _ts_width) * _ts;
						draw_sprite_part(_tileset, 0, _tspx_left, _tspx_top, _ts, _ts, _x * _ts, _y * _ts);
					}/* else if (_tileset < 0  && (_tileID > 0) && Game.debug) {
						// Display the collision tiles if debug is on
						
						draw_set_alpha(0.4);
						draw_sprite(sprWall, 0, _x * _ts, _y * _ts);
						draw_set_alpha(0);
						
					}*/
				} else {
					var _this_tile = tilemap_get(_col_layer_tiles, _x, _y);
					var _tile_index = tile_get_index(_this_tile);
					if (_tile_index >= 1 && _debug_enabled) {
						draw_set_alpha(0.4);
						draw_sprite(sprWall, 0, _x * _ts, _y * _ts);
						draw_set_alpha(1);
					}
				}
				

			}
		}
	}
}