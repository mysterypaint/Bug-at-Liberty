/// @description Insert description here
if (dead)
	exit;

Game.enabled_weapons[Fighters.BEEMISSILE] = true;
sfx_play(sfxGenericObtainPowerup);
with (other) {
	instance_destroy();
}