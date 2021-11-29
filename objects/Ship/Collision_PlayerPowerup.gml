/// @description Insert description here
if (dead)
	exit;

Game.enabled_weapons[Fighters.BEEMISSILE] = true;

with (other) {
	instance_destroy();
}