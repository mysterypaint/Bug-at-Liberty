// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function collide_and_move(){
	if (place_meeting(x + hsp, y, Camera.x) || place_meeting(x + hsp, y, Camera.x + Game.base_res_width)) {
		while(!tile_place_meeting(x + sign(hsp), y, 1) &&
				!place_meeting(x + sign(hsp), y, ParentSolid) &&
				!place_meeting(x + sign(hsp), y, Camera.x) &&
				!place_meeting(x + sign(hsp), y, Camera.x + Game.base_res_width)){
			x += sign(hsp);
		}
		hsp = 0;
		//if tile_place_meeting(x + hsp+1, y, 1){x=floor(x);}
	    //if tile_place_meeting(x + hsp-1, y, 1){x=ceil(x);}
	}
	
	x += hsp * Game.dt;
	
	// Vertical collision check
	if (tile_place_meeting(x, y + vsp, 1) || place_meeting(x, y + vsp, ParentSolid)) {
		while(!tile_place_meeting(x, y + sign(vsp), 1) && !place_meeting(x, y + sign(vsp), ParentSolid)){
			y += sign(vsp);
		}
		vsp = 0;
	}
	
	y += vsp * Game.dt;
}