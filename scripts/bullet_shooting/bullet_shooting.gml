// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function bullet_shooting(){
	if (Ship.dead)
		exit;

	if (Game.key_shoot_pressed) {
		var _ship_bullet_type = Ship.bullet_type;
		var _ship_vsp = Ship.vsp;
		
		if (bullet_count < bullet_count_max) {
			var _bullet = instance_create_depth(x + shoot_x_off, y + shoot_y_off, depth, PlayerBullet);
			_bullet.bullet_type = _ship_bullet_type;
			_bullet.parent_id = id;
			_bullet.depth = depth - 1;
			_bullet.img_index = _ship_bullet_type;
			
			var _bullet_sfx = Game.bullet_sfx[_ship_bullet_type];
			sfx_play(_bullet_sfx, 0, false);
			switch(_ship_bullet_type) {
				case BulletTypes.TERMITE:
					_bullet.vsp = _ship_vsp;
					break;
				case BulletTypes.DRAGONFLY:
					_bullet.vsp = _ship_vsp;
					_bullet.hsp = 4;
					if (bullet_count_two < bullet_count_two_max) {
						var _bullet2 = instance_create_depth(x + shoot_x_off, y + shoot_y_off, depth, PlayerBullet);
						_bullet2.bullet_type = _ship_bullet_type;
						_bullet2.parent_id = id;
						_bullet2.depth = depth - 1;
						_bullet2.img_index = _ship_bullet_type;
						_bullet2.hsp = -3;
						_bullet2.extra_bullet = true; // This is a second bullet, so don't mess with the bullet refresh counter
						bullet_count_two++;
					}
					break;
				case BulletTypes.STAG_BEETLE:
					_bullet.hsp = 4;
					if (bullet_count_two < bullet_count_two_max) {
						var _bullet2 = instance_create_depth(x + shoot_x_off, y + shoot_y_off, depth, PlayerBullet);
						_bullet2.bullet_type = _ship_bullet_type;
						_bullet2.parent_id = id;
						_bullet2.depth = depth - 1;
						_bullet2.img_index = _ship_bullet_type;
						_bullet2.hsp = -3;
						_bullet2.extra_bullet = true; // This is a second bullet, so don't mess with the bullet refresh counter
						bullet_count_two++;
					}
					break;
			}
			bullet_count++;
		}
	}
}