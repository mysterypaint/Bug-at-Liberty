/// @description Insert description here

if (Game.state == GameStates.PAUSED)
	exit;

hsp = Game.move_x * move_speed;
vsp = Game.move_y * move_speed;

//var _player_depth = depth;

// Step the Camera
with (Camera) {
	move_x = 0.2;
	move_y = 0;
		
	// Move the ship, too
	
	if (round_ext(x, .2) % 1 == 0) {
		
		other.hsp += sign(move_x) * Game.dt;
		other.vsp += sign(move_y) * Game.dt;
	}
	
	var _num_bullets = instance_number(PlayerBullet);
	var _cam = id;
	
	for (var _i = 0; _i < _num_bullets; _i++) {
		var _this_bullet = instance_find(PlayerBullet, _i);
		//var _this_bullet = _player_depth + 1;
		with(_this_bullet) {
			if (bullet_type != BulletTypes.STAG_BEETLE) {
				hsp += _cam.move_x * Game.dt;
				vsp += _cam.move_y * Game.dt;
			} else {
				if (!extra_bullet)
					hsp += _cam.move_x * Game.dt;
				vsp += _cam.move_y * Game.dt;
			}
		}
	}
	
	var _mx = move_x;
	var _my = move_y;
	
	with (Textbox) {
		x += (_mx * Game.dt);
		y += (_my * Game.dt);
	}
}

// Step the Player

// Horizontal collision check

/*
var _layer_count = ds_list_size(LevelData.layers);
LevelData.layers[| _layer_count - 2][| 1][# _x div _ts, _y div _ts])
*/

if (tile_place_meeting(x + hsp, y, 1) || place_meeting(x + hsp, y, ParentSolid) || place_meeting(x + hsp, y, Camera.x) || place_meeting(x + hsp, y, Camera.x + Game.base_res_width)) {
	while(!tile_place_meeting(x + sign(hsp), y, 1) &&
			!place_meeting(x + sign(hsp), y, ParentSolid) &&
			!place_meeting(x + sign(hsp), y, Camera.x) &&
			!place_meeting(x + sign(hsp), y, Camera.x + Game.base_res_width)){
		x += sign(hsp);
	}
	hsp = 0;
}

// Don't let player move beyond camera bounds horizontally
if (x + hsp <= Camera.x) {
	x = Camera.x;
	hsp = 0;
} else if (x + hsp >= Camera.x + Game.base_res_width) {
	x = Camera.x + Game.base_res_width;
	hsp = 0;
} else
	x += hsp * Game.dt;

x = round(x);
y = round(y);


// Vertical collision check
if (tile_place_meeting(x, y + vsp, 1) || place_meeting(x, y + vsp, ParentSolid)) {
	while(!tile_place_meeting(x, y + sign(vsp), 1) && !place_meeting(x, y + sign(vsp), ParentSolid)){
		y += sign(vsp);
	}
	vsp = 0;
}


// Don't let player move beyond camera bounds vertically
if (y + vsp <= Camera.y) {
	y = Camera.y;
	vsp = 0;
} else if (y + vsp >= Camera.y + Game.base_res_height - Game.TILE_SIZE - 8) {
	y = Camera.y + Game.base_res_height - Game.TILE_SIZE - 8;
	vsp = 0;
} else
	y += vsp * Game.dt;

x = round(x);
y = round(y);

// Implement shooting
if (bullet_count < 0)
	bullet_count = 0;
if (bullet_count_two < 0)
	bullet_count_two = 0;

if (Game.key_shoot_pressed) {
	if (bullet_count < bullet_count_max) {
		var _bullet = instance_create_depth(x + shoot_x_off, y + shoot_y_off, depth, PlayerBullet);
		_bullet.bullet_type = bullet_type;
		_bullet.parent_id = id;
		_bullet.depth = depth - 1;
		_bullet.img_index = bullet_type;
	
		switch(bullet_type) {
			case BulletTypes.TERMITE:
				_bullet.vsp = vsp;
				break;
			case BulletTypes.DRAGONFLY:
				_bullet.vsp = vsp;
				_bullet.hsp = 4;
				if (bullet_count_two < bullet_count_two_max) {
					var _bullet2 = instance_create_depth(x + shoot_x_off, y + shoot_y_off, depth, PlayerBullet);
					_bullet2.bullet_type = bullet_type;
					_bullet2.parent_id = id;
					_bullet2.depth = depth - 1;
					_bullet2.img_index = bullet_type;
					_bullet2.hsp = -3;
					_bullet2.extra_bullet = true; // This is a second bullet, so don't mess with the bullet refresh counter
					bullet_count_two++;
				}
				break;
			case BulletTypes.STAG_BEETLE:
				_bullet.hsp = 4;
				if (bullet_count_two < bullet_count_two_max) {
					var _bullet2 = instance_create_depth(x + shoot_x_off, y + shoot_y_off, depth, PlayerBullet);
					_bullet2.bullet_type = bullet_type;
					_bullet2.parent_id = id;
					_bullet2.depth = depth - 1;
					_bullet2.img_index = bullet_type;
					_bullet2.hsp = -3;
					_bullet2.extra_bullet = true; // This is a second bullet, so don't mess with the bullet refresh counter
					bullet_count_two++;
				}
				break;
		}
		bullet_count++;
	}
}


if (Game.key_speedchange_pressed) {
	bullet_type++;
	
	if (bullet_type >= Fighters.MAX)
		bullet_type = 0;
	
	bullet_count_max = 4;
	bullet_count_two_max = 4;
	
	if (bullet_type == BulletTypes.DRAGONFLY || bullet_type == BulletTypes.STAG_BEETLE) {
		bullet_count_max = 1;
		bullet_count_two_max = 1;
	}
}

/*
if (mouse_check_button(mb_left)){
	x = mouse_x;
	y = mouse_y;
}*/

// Animation Handling
if (Game.move_y >= 1) {
	img_index_offset = ShipAnimations.DOWN * img_ani_frames_max;
} else if (Game.move_y <= -1) {
	img_index_offset = ShipAnimations.UP * img_ani_frames_max;
} else {
	img_index_offset = ShipAnimations.NEUTRAL * img_ani_frames_max;
}

with (Camera) {
	
	x += (move_x * Game.dt);
	y += (move_y * Game.dt);
	camera_set_view_pos(view_camera[0], x, y);
}