/// @description State Machine; Kill if <0 HP
if (hp <= 0 && hp > -99999)
	instance_destroy();

switch (state) {
	case EnemyStates.UNLOADED:
		if (!checked_if_already_has_this_bug) {
			var _inst_ship = Ship;
			for (var _i = 2; _i >= 0; _i--) {
				var _this_helper = _inst_ship.helpers[_i];
				if (_this_helper.bug_type == bug_type)
					instance_destroy();
			}
			checked_if_already_has_this_bug = true;
		}
		
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
		var _inst_player_bullet = instance_place(x, y, ParentPlayerBullet);
		if (_inst_player_bullet != noone) {
			var _inst_ship = Ship;
			if (_inst_ship.dead)
				exit;
			
			switch(bug_type) {
				default:
				case 0:
					freed_sprite = sprCapsuleDragonflyFreed;
					break;
				case 1:
					freed_sprite = sprCapsuleButterflyFreed;
					break;
				case 2:
					freed_sprite = sprCapsuleFireflyFreed;
					break;
			}
			
			sprite_index = sprCapsulePrisonDestroyed;
			spr_index = sprite_index;
			state = EnemyStates.MOVING;
		}
		break;
	case EnemyStates.MOVING:
		var _inst_ship = instance_place(x, y, Ship);
		if (_inst_ship != noone) {
			var _helper_spr_index = sprDragonfly;
			var _ani_max_frames = 2;
			var _weapon_id = 0;
			switch(bug_type) {
				default:
				case 0:
					_helper_spr_index = sprDragonfly;
					_weapon_id = Fighters.DRAGONFLY;
					break;
				case 1:
					_helper_spr_index = sprButterfly;
					_ani_max_frames = 4;
					_weapon_id = Fighters.BUTTERFLY;
					break;
				case 2:
					_helper_spr_index = sprFirefly;
					_weapon_id = Fighters.FIREFLY;
					break;
			}
			
			var _bug_type = bug_type;
			Game.enabled_weapons[_weapon_id] = true;
			
			if (Game.obtain_caged_helpers) {
				with (_inst_ship) {
					helpers_activated++;
					var _this_helper = helpers[helpers_activated];
					_this_helper.sprite_index = _helper_spr_index;
					_this_helper.spr_index = _this_helper.sprite_index;
					_this_helper.activated = true;
					_this_helper.ani_max_frames = _ani_max_frames;
					_this_helper.bug_type = _bug_type;
				}
			}
			//instance_destroy();
			
			sfx_play(sfxHelperBugRecruit);
			state = EnemyStates.DYING;
		}
		break;
	case EnemyStates.DYING:
		break;
}

// De-spawn if too far away from the camera
despawn_if_oob();

img_index += img_speed * Game.dt;
if (img_index > ani_max_frames)
	img_index = 0;

freed_img_index += freed_img_speed * Game.dt;
if (freed_img_index > freed_ani_max_frames)
	freed_img_index = 0;

time_alive += Game.dt;