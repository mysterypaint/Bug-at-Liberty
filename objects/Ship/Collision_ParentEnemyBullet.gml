/// @description Insert description here
if (dead)
	exit;

if (Game.debug) {
	sfx_play(sfxDebugPlayerHit);
	//other.HP--;
	instance_destroy(other);
} else {
	kill_player();
}