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
			if (bullet_type != BulletTypes.DRAGONFLY) {
				hsp_carry += _cam.move_x * Game.dt;
			} else {
				if (!extra_bullet)
					hsp_carry += _cam.move_x * Game.dt;
				else {
					hsp_carry -= _cam.move_x * Game.dt;
				}
			}
			vsp_carry += _cam.move_y * Game.dt;
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
var _fan = instance_find(EnemyOverlayFan, 0);
var _wind_drag = 0;
if (_fan != noone) {
	if (_fan.img_speed > 0) {
		_wind_drag = wind_drag_speed;
	}
}

hsp = Game.move_x * move_speed + _mx + _wind_drag;
vsp = Game.move_y * move_speed + _my;

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
	_wind_drag = 0;
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
var _cam_y_top_bounds = Camera.y - 15;
var _cam_y_bottom_bounds = Camera.y + Game.base_res_height - Game.TILE_SIZE - 8;
if (y + vsp <= _cam_y_top_bounds) {
	y = _cam_y_top_bounds;
	vsp = 0;
} else if (y + vsp >= _cam_y_bottom_bounds) {
	y = _cam_y_bottom_bounds;
	vsp = 0;
	y = round(y);
} else
	y += vsp * Game.dt;



// Helper ghost x/y handling
if (Game.move_x != 0 || Game.move_y != 0) {
	//Shift all the X/Y previous positions down the bank
	for (var i = 29; i > 0; i--;) {
		player_ghost_x[i] = player_ghost_x[i - 1];
		player_ghost_y[i] = player_ghost_y[i - 1];
	}
	
	//Finally, store X/Y in the first position
	player_ghost_x[0] = x;
	player_ghost_y[0] = y;
}

// Regardless we're moving or not, update every single X/Y ghost position with the camera scrolling
for (var i = 29; i >= 0; i--;) {
	player_ghost_x[i] += (_mx + _wind_drag) * Game.dt;
	player_ghost_y[i] += _my * Game.dt;
}

// Update all the helpers' positions
for (var _i = 2; _i >= 0; _i--) {
	var _this_helper = helpers[_i];
	_this_helper.x = player_ghost_x[_i * 10 + 9] + _mx;
	_this_helper.y = player_ghost_y[_i * 10 + 9] + _my;
}


// Implement shooting
if (bullet_count < 0)
	bullet_count = 0;
if (bullet_count_two < 0)
	bullet_count_two = 0;

bullet_shooting();


if (Game.key_weapon_change_forward_pressed) {
	if (bullet_type + 1 <= Fighters.MAX - 1)
		bullet_type++;
	else
		bullet_type = 0;
	
	while (Game.enabled_weapons[bullet_type] == false && !Game.debug) {
		
		bullet_type++;
		
		if (bullet_type > Fighters.MAX - 1)
			bullet_type = 0;
	}
	
	update_player_bullet_max(bullet_type);
} else if (Game.key_weapon_change_backward_pressed) {

	if (bullet_type - 1 >= 0)
		bullet_type--;
	else
		bullet_type = Fighters.MAX - 1;
	
	while (Game.enabled_weapons[bullet_type] == false && !Game.debug) {
		
		bullet_type--;
		
		if (bullet_type < 0)
			bullet_type = Fighters.MAX - 1;
	}
	
	update_player_bullet_max(bullet_type);
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