/// @description Insert description here
if (has_small_explosion) {
	if (!silent_death && object_index != EnemyBodyExtension) {
		sfx_play(sfxGenericEnemyExplosion);
		instance_create_depth(x, y, depth, ExplosionSmall);
	}
}