/// @description Insert description here
img_index += img_speed * Game.dt;

if (img_index > ani_max_frames)
	instance_destroy();
else if (img_index == 4) {
	parent_id.spr_index = sprCapsulePrisonDestroyed;
}