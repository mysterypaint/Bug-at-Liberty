// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function tile_place_meeting(_x, _y, _checking_tile_id) {
	if (!instance_exists(LevelData))
		return false;
	
	var _hsp = _x - x;
	var _vsp = _y - y;
	
	col = ( tile_place_meeting_px(bbox_left + _hsp, bbox_top + _vsp, _checking_tile_id)   ||
        tile_place_meeting_px(bbox_right + _hsp, bbox_top + _vsp, _checking_tile_id)  ||
        tile_place_meeting_px(bbox_left + _hsp, bbox_bottom + _vsp, _checking_tile_id) ||
        tile_place_meeting_px(bbox_right + _hsp, bbox_bottom + _vsp, _checking_tile_id));
 
	return col;
}