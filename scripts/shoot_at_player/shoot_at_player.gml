// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function shoot_at_player(_type) {
	var _direction = point_direction(x, y, Ship.x, Ship.y);

	_direction += irandom_range(-10, 10);
	if (_type == EnemyBulletTypes.SMALL) { // Small, slow bullet
		var _new_bullet = instance_create_depth(x + shoot_x_off, y + shoot_y_off, depth, EnemyBulletSmall);
		_new_bullet.direction = _direction;
		_new_bullet.spd = 0.8;
	}
	else if (_type == EnemyBulletTypes.LARGE) { // Large, fast bullet
		var _new_bullet = instance_create_depth(x + shoot_x_off, y + shoot_y_off, depth, EnemyBulletLarge);
		
		if (object_index == EnemyHumanBossFace) {
			_direction = random_range(130, 210);
			_new_bullet.spd = random_range(0.3, 2.5);
		} else {
			_new_bullet.spd = 1.7;
		}
		
		_new_bullet.direction = _direction;
		
	}
	else if (_type == EnemyBulletTypes.SNEEZE) { // Large, fast bullet
		var _direction = random_range(130, 210);
		var _new_bullet = instance_create_depth(x + shoot_x_off, y + shoot_y_off, depth, EnemyBulletSneeze);
		_new_bullet.direction = _direction;
		_new_bullet.spd = random_range(0.3, 2.5);
	}
}

