/// @description Insert description here
if (dead)
	exit;

if (Game.debug) {
	audio_play_sound(sfxPlayerHit, 0, false);
	//other.HP--;
	instance_destroy(other);
} else {
	kill_player();
}