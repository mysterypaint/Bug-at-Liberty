/// @description Insert description here

screenshake = 0;
x = 0;
y = 0;
camera_set_view_pos(view_camera[0], x + screenshake_xoff, y + screenshake_yoff);
Game.state = GameStates.VICTORY_SCREEN;