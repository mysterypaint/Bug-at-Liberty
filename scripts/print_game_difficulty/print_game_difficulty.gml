// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function print_game_difficulty(_difficulty) {
	switch(_difficulty) {
		case GameDifficulties.REGULAR:
			return "Regular";
		case GameDifficulties.ARCADE:
			return "Arcade";
		case GameDifficulties.NIGHTMARE:
			return "Nightmare";
	}
	return "Undefined";
}