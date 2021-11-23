/// @description State Machine; Kill if <0 HP
if (hp <= 0 && hp > -2)
	instance_destroy();

switch (state) {
	case EnemyStates.UNLOADED:
		if (Camera.x + Game.base_res_width < x)
			exit; // The player has not reached this enemy yet.
		else {
			state = EnemyStates.IDLE;
			switch(bug_type) {
				default:
				case 0:
					sprite_index = sprCapsulePrisonDragonfly;
					break;
				case 1:
					sprite_index = sprCapsulePrisonButterfly;
					break;
				case 2:
					sprite_index = sprCapsulePrisonFirefly;
					break;
			}
			spr_index = sprite_index;
		}
		break;
	case EnemyStates.IDLE:
		var _inst_ship = instance_place(x, y, Ship);
		if (_inst_ship != noone) {
			if (_inst_ship.dead)
				exit;
			var _helper_spr_index = sprDragonfly;
			switch(bug_type) {
				default:
				case 0:
					_helper_spr_index = sprDragonfly;
					break;
				case 1:
					_helper_spr_index = sprButterfly;
					break;
				case 2:
					_helper_spr_index = sprFirefly;
					break;
			}
			
			with (_inst_ship) {
				helpers_activated++;
				var _this_helper = helpers[helpers_activated];
				_this_helper.sprite_index = _helper_spr_index;
				_this_helper.spr_index = _this_helper.sprite_index;
				_this_helper.activated = true;
			}
			instance_destroy();
		}
		break;
}

// De-spawn if too far away from the camera
despawn_if_oob();

img_index += img_speed * Game.dt;
if (img_index > ani_max_frames)
	img_index = 0;

time_alive += Game.dt;