/// @description Insert description here

if (state != EnemyStates.UNLOADED) {
	if (hp > -2)
		hp--;
}

with (other)
	instance_destroy();