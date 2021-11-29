// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function player_shoot_primary_bullet(_ship_bullet_type) {
	var _bullet = noone;
	
	if (bullet_count < bullet_count_max) {
		_bullet = instance_create_depth(x + shoot_x_off, y + shoot_y_off, depth, PlayerBullet);
		_bullet.bullet_type = _ship_bullet_type;
		_bullet.parent_id = id;
		_bullet.depth = depth - 1;
		_bullet.sprite_index = Ship.bullet_sprites[_ship_bullet_type];
		_bullet.spr_index = _bullet.sprite_index;
			
		var _bullet_sfx = Game.bullet_sfx[_ship_bullet_type];
		sfx_play(_bullet_sfx, 0, false);
		bullet_count++;
	}
	
	return _bullet;
}