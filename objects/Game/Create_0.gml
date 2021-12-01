/// @description
global_debug = false;
debug = false;
reset_helpers_on_death = true;
obtain_caged_helpers = true;
unlock_all_weapons = false;
game_difficulty = GameDifficulties.REGULAR;
game_end_timer = 300;
victory_screen_timer = 60 * 5;
stop_endgame_explosions = false;

enum GameDifficulties {
	REGULAR,
	ARCADE,
	NIGHTMARE,
	MAX
};

enum GameStates {
	INIT,
	TITLE,
	GAMEPLAY,
	PAUSED,
	GAMEOVER,
	FADE_TO_VICTORY_SCREEN,
	VICTORY_SCREEN,
	CREDITS
};

bullet_sfx[BulletTypes.LADYBUG] = sfxBullet1;
bullet_sfx[BulletTypes.DRAGONFLY] = sfxBullet2;
bullet_sfx[BulletTypes.BUTTERFLY] = sfxBullet3;
bullet_sfx[BulletTypes.BEE] = sfxBullet4;
bullet_sfx[BulletTypes.FIREFLY] = sfxBullet5;
//bullet_sfx[BulletTypes.STAG_BEETLE] = sfxBullet6;
//bullet_sfx[BulletTypes.MAX] = sfxBullet7;

state = GameStates.INIT;
prev_state = state;
curr_bgm = undefined;
bgm = undefined;
bgm_intro_length = 0.0;
bgm_loop_length = 0.0;
bgm_total_length = 0.0;
mute_bgm = false;

tick = 0;
begin_game_timer = -1;
begin_game_timer_reset = 80;

pause_timer = 0;
pause_timer_reset = 10;
title_screen_show_controls = false;

base_res_width = 320;
base_res_height = 180;
zoom_size = 4;
zoom_size_max = floor(display_get_width() / base_res_width);

player_lives = 5;
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

key_weapon_change_forward = ord("L");
key_weapon_change_forward_alt = ord("C");
key_weapon_change_backward = ord("K");
key_weapon_change_backward_alt = ord("X");

key_confirm = ord("K");
key_confirm_alt = ord("X");
key_cancel = ord("J");
key_cancel_alt = ord("Z");

key_pause = vk_enter;
key_pause_alt = ord("H");

enabled_weapons[Fighters.STARTING] = true;
enabled_weapons[Fighters.DRAGONFLY] = false;
enabled_weapons[Fighters.BUTTERFLY] = false;
enabled_weapons[Fighters.BEEMISSILE] = false;
enabled_weapons[Fighters.FIREFLY] = false;

if (unlock_all_weapons) {
	enabled_weapons[Fighters.DRAGONFLY] = true;
	enabled_weapons[Fighters.BUTTERFLY] = true;
	enabled_weapons[Fighters.BEEMISSILE] = true;
	enabled_weapons[Fighters.FIREFLY] = true;
}
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

// Textbox stuff
enum Portraits {
	LADYBUG,
	DRAGONFLY,
	BUTTERFLY,
	BEE,
	FIREFLY,
	STAG_BEETLE,
	MAX
};

text_contents = ds_grid_create(4, 0);
text_contents_add(Portraits.LADYBUG, "Ladybug", "Never gonna give you up\nNever gonna let you down\nNever gonna run around\nand desert you", 250);
text_contents_add(Portraits.DRAGONFLY, "Dragonfly", "Never gonna make you cry\nNever gonna say goodbye\nNever gonna tell a lie...\nand hurt you!", 250);

level_data_obj = noone;