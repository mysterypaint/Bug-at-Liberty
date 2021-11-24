/// @description Insert description here

switch (state) {
	case EnemyStates.IDLE:
		if (time_alive >= 15)
			state = EnemyStates.ATTACKING;
		else
			fan_x_off += Game.dt;
		break;
	case EnemyStates.ATTACKING:
		img_index += img_speed * Game.dt;
		if (img_index >= ani_max_frames)
			img_index = 0;

		if (time_alive >= duration) {
			img_index = 0;
			img_speed = 0;
			state = EnemyStates.DYING;
		}
		break;
	case EnemyStates.DYING:
		fan_x_off -= Game.dt;
		
		if (fan_x_off <= 0)
			instance_destroy();
		break;
}

time_alive += Game.dt;