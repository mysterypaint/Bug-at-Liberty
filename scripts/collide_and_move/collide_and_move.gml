// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function collide_and_move(){
	if (place_meeting(x + hsp, y, Camera.x) || place_meeting(x + hsp, y, Camera.x + Game.base_res_width)) {
		var _timeout_x = 0;
		while(!tile_place_meeting(x + sign(hsp), y, 1) &&
				!place_meeting(x + sign(hsp), y, ParentSolid) &&
				!place_meeting(x + sign(hsp), y, Camera.x) &&
				!place_meeting(x + sign(hsp), y, Camera.x + Game.base_res_width)){
					
			if (_timeout_x > 400) {
				hsp = 0;
				break;
			}
			x += sign(hsp);
			_timeout_x++;
		}
		hsp = 0;
		//if tile_place_meeting(x + hsp+1, y, 1){x=floor(x);}
	    //if tile_place_meeting(x + hsp-1, y, 1){x=ceil(x);}
	}
	
	x += hsp * Game.dt;
	
	// Vertical collision check
	if (tile_place_meeting(x, y + vsp, 1) || place_meeting(x, y + vsp, ParentSolid)) {
		var _timeout_y = 0;
		while(!tile_place_meeting(x, y + sign(vsp), 1) && !place_meeting(x, y + sign(vsp), ParentSolid)){
			if (_timeout_y > 400) {
				hsp = 0;
				break;
			}
			y += sign(vsp);
			_timeout_y++;
		}
		vsp = 0;
	}
	
	y += vsp * Game.dt;
}