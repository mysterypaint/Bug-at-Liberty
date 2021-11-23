/// @description State Machine; Kill if <0 HP
if (hp <= 0 && hp > -2)
	instance_destroy();

switch (state) {
	case EnemyStates.UNLOADED:
		if (Camera.x + Game.base_res_width < x)
			exit; // The player has not reached this enemy yet.
		else
			state = EnemyStates.IDLE;
		break;
	case EnemyStates.IDLE:
		if (jump_timer <= 0) {
			img_index_offset = 1;
			state = EnemyStates.JUMPING;
			vsp = -jump_speed;
			jump_timer = jump_timer_reset;
		} else {
			jump_timer -= Game.dt;
		}
		break;
	case EnemyStates.JUMPING:
		hsp = -move_speed;

		if (vsp < grav_max)
			vsp += grav * Game.dt;
		
		// Go back to idle if we landed on the ground
		if (tile_place_meeting(x, y + vsp, 1) && vsp > 0) {
			while (!tile_place_meeting(x, y + 1, 1)) {
				y++;
			}
			vsp = 0;
			state = EnemyStates.IDLE;
			img_index_offset = 0;
		}
		
		// Horizontal Collision Check
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
	
		// Vertical collision check; Reset state back to Idle if we hit a wall
		if (tile_place_meeting(x, y + vsp, 1) || place_meeting(x, y + vsp, ParentSolid)) {
			while(!tile_place_meeting(x, y + sign(vsp), 1) && !place_meeting(x, y + sign(vsp), ParentSolid)){
				y += sign(vsp);
			}
			vsp = 0;
		}
	
		y += vsp * Game.dt;
		break;
	case EnemyStates.DYING:
		break;
}


	

// De-spawn if too far away from the camera
despawn_if_oob();


time_alive += Game.dt;