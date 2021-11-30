/// @description Insert description here
switch (state) {
	case EnemyStates.UNLOADED:
		if (Camera.x < x)
			exit; // The player has not reached this enemy yet.
		else {
			if (Game.checkpoint < x && !Ship.dead) {
				Game.checkpoint = x;
				Camera.checkpoint_display_timer = Camera.checkpoint_display_timer_reset;
				sfx_play(sfxCheckpointReached);
			}
			instance_destroy();
		}
		break;
}