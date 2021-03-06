/// @description Insert description here
// Inherit the parent event
event_inherited();
draw_me = false;

cam_bounds_x_min = Game.TILE_SIZE * 50;
cam_bounds_y_min = Game.TILE_SIZE * 50;
cam_bounds_x_max = Game.base_res_width + Game.TILE_SIZE * 50;
cam_bounds_y_max = Game.base_res_height + Game.TILE_SIZE * 50;

sprite_index = sprHandHorizontal1;
spr_index = sprite_index;

wait_timer = 0;
draw_me = false;
moving_left = false;
hp = -99999; // Infinite HP
can_hurt_player = false;

padding = 2;

punching_state = 0; // 1 -> Punch moves to the right; -1 -> Punch moves to the left
punching_speed = 10;

caution_img_index = 0;
caution_ani_max_frames = 4;
caution_img_speed = 0.2;

dual_slam = false;
impact_point_offset = 0;

// Create the arm for this hand
mask_index = -1;

body_extension = instance_create_depth(-5000, -5000, depth, EnemyBodyExtension);
body_extension.hp = -99999;

if (spr_index == sprHandHorizontal1) {
	body_extension.sprite_index = sprArmHorizontal1;
	hand_width = 10;
} else {
	body_extension.sprite_index = sprLegHorizontal1;
	hand_width = 8;
}
arm_width = 320 - hand_width;
x_offset = hand_width;//-Game.base_res_width - padding;
body_extension.spr_index = body_extension.sprite_index;
body_extension.mask_index = body_extension.spr_index;
body_extension.can_hurt_player = false;
//body_extension.x = x - arm_width;
//body_extension.y = y;


/*

			var _xx = floor(Camera.x/16);
			var _yy = floor(Camera.y/16);
			show_message("Cam pos: " + string(_xx) + ", " + string(_yy));
			
			*/