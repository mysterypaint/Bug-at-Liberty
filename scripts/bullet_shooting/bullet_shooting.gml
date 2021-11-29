// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function bullet_shooting(){
	if (Ship.dead)
		exit;
	
	if (butterfly_cooldown_timer > 0) {
		butterfly_cooldown_timer -= Game.dt;
		exit;
	}

	if (Game.key_shoot_pressed) {
		var _ship = Ship;
		var _ship_bullet_type = _ship.bullet_type;
		
		var _bullet = player_shoot_primary_bullet(_ship_bullet_type);
		var _bullet_sfx = Game.bullet_sfx[_ship_bullet_type];
		
		switch(_ship_bullet_type) {
			case BulletTypes.BUTTERFLY:
				if (_bullet != noone) {
					_bullet.death_time = _bullet.bullet_butterfly_life_timer;
					_bullet.atk_stat = 3;
				}
				
				for (var _i = 0; _i < 13; _i++) {
						
					var _bullet2 = instance_create_depth(x + shoot_x_off, y + shoot_y_off, depth, PlayerBullet);
					_bullet2.bullet_type = _ship_bullet_type;
					_bullet2.parent_id = id;
					_bullet2.depth = depth - 1;
					_bullet2.sprite_index = _ship.bullet_sprites[_ship_bullet_type];
					_bullet2.spr_index = _bullet2.sprite_index;
					_bullet2.death_time = _bullet2.bullet_butterfly_life_timer;
					_bullet2.delay_timer = irandom(5);
					_bullet2.atk_stat = 3;
					
					// Randomly, pick an angle between quadrant 1 and quadrant 4
					var _new_angle_range_1 = irandom_range(0, 45); // quadrant 1
					var _new_angle_range_2 = irandom_range(270, 360); // quadrant 4
					var _new_angle = choose(_new_angle_range_1, _new_angle_range_2);
						
					// Shoot the bullet toward that new angle
					var _spd = _bullet2.bullet_butterfly_speed;
					var _rax = lengthdir_x(_spd, _new_angle);
					var _ray = lengthdir_y(_spd, _new_angle);
					_bullet2.hsp = _rax;
					_bullet2.vsp = _ray;
					sfx_play(_bullet_sfx, 0, false);
						
					bullet_count++;
					butterfly_cooldown_timer = butterfly_cooldown_timer_reset;
				}
				break;
			case BulletTypes.DRAGONFLY:
				if (_bullet != noone) {
					_bullet.atk_stat = 0.2;
				}
				if (bullet_count_two < bullet_count_two_max) {
					var _bullet2 = instance_create_depth(x + shoot_x_off, y + shoot_y_off, depth, PlayerBullet);
					_bullet2.bullet_type = _ship_bullet_type;
					_bullet2.parent_id = id;
					_bullet2.depth = depth - 1;
					_bullet2.sprite_index = _ship.bullet_sprites[_ship_bullet_type];
					_bullet2.spr_index = _bullet2.sprite_index;
					_bullet2.hsp = -3;
					_bullet2.extra_bullet = true; // This is a second bullet, so don't mess with the bullet refresh counter
					_bullet2.atk_stat = 0.4;
					sfx_play(_bullet_sfx, 0, false);
					bullet_count_two++;
				}
				break;
			case BulletTypes.FIREFLY:
				if (_bullet != noone) {
					_bullet.atk_stat = 0.1;
				}
				if (bullet_count_two < bullet_count_two_max) {
					var _bullet2 = instance_create_depth(x + shoot_x_off, y + shoot_y_off, depth, PlayerBullet);
					_bullet2.gravity_enabled = true;
					_bullet2.bullet_type = _ship_bullet_type;
					_bullet2.parent_id = id;
					_bullet2.atk_stat = 0.2;
					_bullet2.depth = depth - 1;
					_bullet2.sprite_index = _ship.bullet_sprites[_ship_bullet_type];
					_bullet2.spr_index = _bullet2.sprite_index;
					_bullet2.extra_bullet = true; // This is a second bullet, so don't mess with the bullet refresh counter
					sfx_play(_bullet_sfx, 0, false);
					bullet_count_two++;
				}
				break;
			case BulletTypes.BEE:
				if (_bullet != noone) {
					_bullet.hsp = -4;
					_bullet.atk_stat = 0.6;
				}
				break;
			/*
			case BulletTypes.STAG_BEETLE:
				if (bullet_count_two < bullet_count_two_max) {
					var _bullet2 = instance_create_depth(x + shoot_x_off, y + shoot_y_off, depth, PlayerBullet);
					_bullet2.bullet_type = _ship_bullet_type;
					_bullet2.parent_id = id;
					_bullet2.depth = depth - 1;
					_bullet2.sprite_index = _ship.bullet_sprites[_ship_bullet_type];
					_bullet2.spr_index = _bullet2.sprite_index;
					_bullet2.hsp = -3;
					_bullet2.extra_bullet = true; // This is a second bullet, so don't mess with the bullet refresh counter
					bullet_count_two++;
				}
				break;
			*/
		}
	}
}