/// @description Insert description here

if (Game.state == GameStates.PAUSED)
	exit;

if (dead) {
	x += Camera.prev_move_x * Game.dt;
	y += Camera.prev_move_y * Game.dt;
	
	if (death_timer > 0)
		death_timer--;
	else if (death_timer == 0) {
		death_timer = -1;
		
		var _vfx = instance_create_depth(0, 0, 0, FadeEffect);
		_vfx.transition_type = TransitionTypes.LEVEL_RESET;
		_vfx.parent_id = id;
	}
	
	if (!instance_exists(FadeEffect)) {
		with (Camera) {
			x += (move_x * Game.dt);
			y += (move_y * Game.dt);
			camera_set_view_pos(view_camera[0], x, y);
		
			var _mx = move_x;
			var _my = move_y;
	
			with (Textbox) {
				x += (_mx * Game.dt);
				y += (_my * Game.dt);
			}
		}
	}
	exit;
}

//var _player_depth = depth;

if (init_player > 0) {
	if (!instance_exists(FadeEffect))
		init_player -= Game.dt;
	exit;
}


// Step the Camera
with (Camera) {
	
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

hsp = Game.move_x * move_speed + _mx;
vsp = Game.move_y * move_speed + _my;

if (Game.move_x != 0 || Game.move_y != 0) {
	//Shift all the X/Y previous positions down the bank
	for (var i = 29; i > 0; i--;) {
		player_ghost_x[i] = player_ghost_x[i - 1];
		player_ghost_y[i] = player_ghost_y[i - 1];
	}
	
	//Finally, store X/Y in the first position
	player_ghost_x[0] = x + hsp;
	player_ghost_y[0] = y + vsp;
}

// Regardless we're moving or not, update every single X/Y ghost position with the camera scrolling
for (var i = 29; i >= 0; i--;) {
	player_ghost_x[i] += _mx * Game.dt;
	player_ghost_y[i] += _my * Game.dt;
}

// Update all the helpers' positions
for (var _i = 2; _i >= 0; _i--) {
	var _this_helper = helpers[_i];
	_this_helper.x = player_ghost_x[_i * 10 + 9] + _mx;
	_this_helper.y = player_ghost_y[_i * 10 + 9] + _my;
}


// Horizontal collision check

/*
var _layer_count = ds_list_size(LevelData.layers);
LevelData.layers[| _layer_count - 2][| 1][# _x div _ts, _y div _ts])
*/

var _enemy_id = instance_place(x + hsp, y, ParentEnemy);

if (tile_place_meeting(x + hsp, y, 1) || place_meeting(x + hsp, y, ParentSolid) || _enemy_id != noone) {
	if (_enemy_id != noone) {
		if (_enemy_id.state != EnemyStates.UNLOADED && _enemy_id.can_hurt_player) {
			kill_player(); // Only kill the player if we collided with the enemy while it's not unloaded
		}
	} else
		kill_player();
}

if (place_meeting(x + hsp, y, Camera.x) || place_meeting(x + hsp, y, Camera.x + Game.base_res_width)) {
	while(!tile_place_meeting(x + sign(hsp), y, 1) &&
			!place_meeting(x + sign(hsp), y, ParentSolid) &&
			!place_meeting(x + sign(hsp), y, Camera.x) &&
			!place_meeting(x + sign(hsp), y, Camera.x + Game.base_res_width)){
		x += sign(hsp);
	}
	
	hsp = 0;
	if tile_place_meeting(x + hsp+1, y, 1){x=floor(x);}
    if tile_place_meeting(x + hsp-1, y, 1){x=ceil(x);}
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

_enemy_id = instance_place(x, y + vsp, ParentEnemy);
// Vertical collision check
if (tile_place_meeting(x, y + vsp, 1) || place_meeting(x, y + vsp, ParentSolid) || _enemy_id != noone) {
	if (_enemy_id != noone) {
		if (_enemy_id.state != EnemyStates.UNLOADED && _enemy_id.can_hurt_player)
			kill_player(); // Only kill the player if we collided with the enemy while it's not unloaded
	} else
		kill_player();
	/*
	while(!tile_place_meeting(x, y + sign(vsp), 1) && !place_meeting(x, y + sign(vsp), ParentSolid)){
		y += sign(vsp);
	}*/
	//vsp = 0;
}


// Don't let player move beyond camera bounds vertically
if (y + vsp <= Camera.y) {
	y = Camera.y;
	vsp = 0;
} else if (y + vsp >= Camera.y + Game.base_res_height - Game.TILE_SIZE - 8) {
	y = Camera.y + Game.base_res_height - Game.TILE_SIZE - 8;
	vsp = 0;
	y = round(y);
} else
	y += vsp * Game.dt;


// Implement shooting
if (bullet_count < 0)
	bullet_count = 0;
if (bullet_count_two < 0)
	bullet_count_two = 0;

bullet_shooting();


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

if (!dead) {
	with (Camera) {
		x += (move_x * Game.dt);
		y += (move_y * Game.dt);
		camera_set_view_pos(view_camera[0], x, y);
	}
}