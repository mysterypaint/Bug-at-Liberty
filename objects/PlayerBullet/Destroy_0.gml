/// @description Subtract from the parent (Ship)'s bullet counter
if (!extra_bullet) { // Make sure this bullet didn't spawn simultaneously with another
	with(parent_id) {
		bullet_count--; // Forget about this bullet within the ship
	}
} else if (extra_bullet) {
	with(parent_id) {
		bullet_count_two--; // Forget about this bullet within the ship
	}
}