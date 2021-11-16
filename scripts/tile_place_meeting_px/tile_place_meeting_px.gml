// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function tile_place_meeting_px(_x, _y, _checking_tile_id){
	if (!instance_exists(LevelData))
		return false;
	
	var _ts = Game.TILE_SIZE;
	var _tilelayer_id = layer_tilemap_get_id(LevelData.collision_layer);
	
	//var _tl = layer_tilemap_get_id_fixed(_tilelayer_id); //LevelData.collision_layer_tiles
	var _this_tile = tilemap_get(LevelData.collision_layer_tiles, floor(_x / _ts), floor(_y / _ts));
	if (_this_tile >= 0) {
		var _tile_index = tile_get_index(_this_tile);
		return _tile_index >= _checking_tile_id;
	}
	return false;
}