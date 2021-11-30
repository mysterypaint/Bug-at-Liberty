/// @description State Machine; Kill if <0 HP
if (hp <= 0 && hp > -99999)
	instance_destroy();

switch (state) {
	case EnemyStates.UNLOADED:
		if (Camera.x + Game.base_res_width < x)
			exit; // The player has not reached this enemy yet.
		else {
			if (!initially_flying && tile_place_meeting(x, y + 1, 1)) {
				state = EnemyStates.IDLE;
				spr_index = sprCockroachIdle;
				img_speed = 0.2;
				sprite_index = spr_index;
				ani_max_frames = sprite_get_number(sprite_index);
				img_xscale = choose(1, -1);
				img_yscale = 1;
			} else {
				state = EnemyStates.FLYING;
				spr_index = sprCockroachFlying;
				img_speed = 0.8;
				sprite_index = spr_index;
				ani_max_frames = sprite_get_number(sprite_index);
				direction = choose(45, 135, 225, 225, 315, 315);
				target_hsp = lengthdir_x(wander_speed, direction);
				target_vsp = lengthdir_y(wander_speed, direction);
				
				cockroach_update_img_xyscale(direction);
			}
			can_hurt_player = true;
			shoot_timer_next = irandom(shoot_timer_max_val);
			shoot_timer = shoot_timer_next;
			wander_timer = irandom_range(20, wander_timer_reset);
		}
		break;
	case EnemyStates.FLYING:
		// Wander around randomly
		if (wander_timer <= 0) {
			// Change flying direction
			direction = choose(45, 135, 225, 225, 315, 315);
			wander_timer = irandom_range(20, wander_timer_reset);
			
			cockroach_update_img_xyscale(direction);
		} else {
			wander_timer -= Game.dt;
		}
		
		target_hsp = lengthdir_x(wander_speed, direction);
		target_vsp = lengthdir_y(wander_speed, direction);
		
		hsp = hsp * (1 - Game.dt * accel_rate) + target_hsp * (Game.dt * accel_rate);
		vsp = vsp * (1 - Game.dt * accel_rate) + target_vsp * (Game.dt * accel_rate);
		
		// If the enemy hits a tile while it's flying downward, change back to idle state (and update any animation metainfo)
		
		if (tile_place_meeting(x + hsp, y, 1)) {
			while(!tile_place_meeting(x + sign(hsp), y, 1)) {
				x += sign(hsp);
			}
			hsp = 0;
			target_hsp = 0;
		}
		x += hsp * Game.dt;
			
		
		if (tile_place_meeting(x, y + vsp, 1)) {
			while(!tile_place_meeting(x, y + sign(vsp), 1)) {
				y += sign(vsp);
			}
			//y--;
			
			if (vsp > 0) {
				state = EnemyStates.IDLE;
				spr_index = sprCockroachIdle;
				img_speed = 0.2;
				sprite_index = spr_index;
				ani_max_frames = sprite_get_number(sprite_index);
				
				shoot_timer_next = irandom(shoot_timer_max_val);
				shoot_timer = shoot_timer_next;
				wander_timer = irandom(wander_timer_reset * 3);
				
				if (hsp > 0)
					img_xscale = 1;
				else if (hsp < 0)
					img_xscale = -1;
				
				img_yscale = 1;
				vsp = 0;
				target_vsp = 0;
				y--;
			} else {
				vsp *= -1;
				img_yscale *= -1;
			}
		}
		y += vsp * Game.dt;
		break;
	case EnemyStates.IDLE:
		if (!instance_exists(Ship))
			exit;
		hsp = 0;
		vsp = 0;
		
		//cockroach_update_img_xyscale(direction);
		if (wander_timer <= 0) {
			// Start flying in a random (diagonal) direction; update animation info too
			state = EnemyStates.FLYING;
			spr_index = sprCockroachFlying;
			img_speed = 0.8;
			sprite_index = spr_index;
			ani_max_frames = sprite_get_number(sprite_index);
			
			shoot_timer_next = irandom(shoot_timer_max_val);
			shoot_timer = shoot_timer_next;
			wander_timer = irandom_range(20, wander_timer_reset);
			direction = choose(45, 135); // only fly up-left or up-right
			
			target_hsp = lengthdir_x(wander_speed, direction);
			target_vsp = lengthdir_y(wander_speed, direction);
			
			cockroach_update_img_xyscale(direction);
		} else {
			wander_timer -= Game.dt;
		}
		// Shoot at the player
		if (shoot_timer <= 0) {
			var _bullet_type = choose(bullets[0], bullets[0], bullets[0], bullets[1]);
			shoot_at_player(_bullet_type);
			shoot_timer_next = irandom(shoot_timer_max_val);
			shoot_timer = shoot_timer_next;
		}

		if (shoot_timer > 0)
			shoot_timer -= Game.dt;

		break;
	case EnemyStates.MOVING:
		break;
	case EnemyStates.ATTACKING:
		break;
	case EnemyStates.DYING:
		break;
}

if (state != EnemyStates.FLYING)
	collide_and_move();

// De-spawn if too far away from the camera
despawn_if_oob();

img_index += img_speed * Game.dt;
if (img_index > ani_max_frames)
	img_index = 0;

time_alive += Game.dt;
