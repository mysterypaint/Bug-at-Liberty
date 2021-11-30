/// @description Insert description here
var _this_explosion = instance_create_depth(x, y, depth, EnemyExplosion);

if (!silent_death)
	sfx_play(sfxSpiderLargeExplode);

for (var _i = 0; _i < 8; _i++) {
	var _this_small_spider = instance_create_depth(x, y, depth, EnemySpiderSmall);
}