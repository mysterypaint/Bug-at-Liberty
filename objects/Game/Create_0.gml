/// @description
global_debug = true;
debug = false;

enum GameStates {
	INIT,
	TITLE,
	GAMEPLAY,
	PAUSED,
	GAMEOVER,
	CREDITS
};

state = GameStates.INIT;
prev_state = state;

tick = 0;
pause_timer = 0;
pause_timer_reset = 10;

base_res_width = 320;
base_res_height = 180;
zoom_size = 4;
zoom_size_max = floor(display_get_width() / base_res_width);

player_lives = 3;
checkpoint = 0; // x-pos determining where to move the camera and player upon a player death

key_up = vk_up;
key_up_alt = ord("W");
key_down = vk_down;
key_down_alt = ord("S");
key_left = vk_left;
key_left_alt = ord("A");
key_right = vk_right;
key_right_alt = ord("D");

key_shoot = ord("Z");
key_shoot_alt = ord("J");

key_speedchange = ord("L");
key_speedchange_alt = ord("C");

key_confirm = ord("K");
key_confirm_alt = ord("Z");

key_pause = vk_enter;
key_pause_alt = ord("H");


playerShip = noone;


zoom_size = 4;
zoom_size_max = 7;

window_set_size(base_res_width * zoom_size, base_res_height * zoom_size);
alarm[0] = 1;


show_titlescreen_prompt = true;
TITLE_BLINK_SPEED = 30;

show_pause_text = true;
GAME_PAUSED_TEXT_BLINK_SPEED = 30;

spr_font = font_add_sprite(sprFont, ord("!"), true, 1);

TILE_SIZE = 16;

//player_score = 0;

dt = 1; // Delta Time

curr_bgm = -1;

// Textbox stuff
enum Portraits {
	LADYBUG,
	DRAGONFLY,
	TERMITE,
	BEE,
	MOSQUITO,
	STAG_BEETLE,
	MAX
};

text_contents = ds_grid_create(4, 0);
text_contents_add(Portraits.LADYBUG, "Ladybug", "Never gonna give you up\nNever gonna let you down\nNever gonna run around\nand desert you", 250);
text_contents_add(Portraits.DRAGONFLY, "Dragonfly", "Never gonna make you cry\nNever gonna say goodbye\nNever gonna tell a lie...\nand hurt you!", 250);

level_data_obj = noone;