/// @description State Machine; Kill if <0 HP
switch (state) {
	case EnemyStates.UNLOADED:
		if (Camera.x + Game.base_res_width < x)
			exit; // The player has not reached this enemy yet.
		else
			state = EnemyStates.IDLE;
		break;
	case EnemyStates.IDLE:
		if (instance_number(EnemyWasp) <= 5) {
			if (spawn_timer <= 0) {
				instance_create_depth(x, y, depth + 1, EnemyWasp);
				spawn_timer = spawn_timer_reset;
			} else {
				spawn_timer -= Game.dt;
			}
		}
		
		if (inv_frames <= 0) {
			var _inst = instance_place(x, y, ParentPlayerBullet);
			if (_inst != noone) {
				if (hp > 0)
					hp--;
				else {
					hp = -99999;
					
					state = EnemyStates.FALLING;
					sfx_play(sfxWaspNestFalling);
				}
				with (other)
					instance_destroy(_inst);
					
				inv_frames = inv_frames_reset;
			}
			
			draw_me = true;
		} else {
			if (inv_frames % blink_rate == 0)
				draw_me = !draw_me;
			
			inv_frames -= Game.dt;
		}
		break;
	case EnemyStates.FALLING:
		if (vsp < grav_max)
			vsp += grav * Game.dt;
		else
			vsp = grav_max;
		
		if (tile_place_meeting(x, y + vsp, 1)) {
			while(!tile_place_meeting(x, y + sign(vsp), 1)) {
				y += sign(vsp);
			}
			state = EnemyStates.DYING;
			sfx_play(sfxWaspNestExplosion);
			inv_frames = inv_frames_reset;
			img_index_offset = 1;
			img_speed = 0.2;
			vsp = 0;
			
			// Spawn 3 EnemyWasps
			for (var _i = 0; _i < 3; _i++) {
				var _new_wasp = instance_create_depth(x, y, depth, EnemyWasp);
				_new_wasp.move_timer = _new_wasp.move_timer_reset * _i;
			}
		}
		
		y += vsp * Game.dt;
		break;
	case EnemyStates.DYING:
		if (img_index + img_index_offset >= ani_max_frames) {
			img_index = ani_max_frames;
			img_speed = 0;
		}
		if (inv_frames <= 0) {
			// 1 in 3 chance to spawn a player powerup when the wasp nest is destroyed
			var _dice = irandom(3 - 1);
			if (_dice == 0)
				instance_create_depth(x, y, depth, PlayerPowerup);
			instance_destroy();
		} else {
			if (inv_frames % blink_rate == 0)
				draw_me = !draw_me;
				
			inv_frames -= Game.dt;
		}
		break;
}

// De-spawn if too far away from the camera
despawn_if_oob();

img_index += img_speed * Game.dt;
if (img_index > ani_max_frames)
	img_index = 0;

time_alive += Game.dt;