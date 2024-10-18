extends Control
class_name SceneSwitcher
@onready var game_over_screen = load("res://src/scenes/game_over_screen.tscn")
@onready var lev_man = $LevelManager
@onready var win_scene = load("res://src/scenes/win_screen.tscn")
@onready var main_scene = load("res://src/scenes/main_menu.tscn")
var level

func clear_screen():
	for x in get_children():
		if x != lev_man:
			x.queue_free()
	lev_man.free_level()

func game_over():
	clear_screen()
	add_child(game_over_screen.instantiate())

#func add_level_manager() -> LevelManager:
#	var lev_child = lev_man.instantiate()
#	lev_child.init(self)
#	add_child(lev_child)
#	return lev_child	

func next_level():
	clear_screen()
#	var lev = add_level_manager()
	if lev_man.is_last_level(level):
		you_win()
	else:
		lev_man.load_next_level(level)

func retry():
	clear_screen()
#	var lev = add_level_manager()
	lev_man.load_level(level)

func you_win():
	clear_screen()
	add_child(win_scene.instantiate())
	
func main_menu():
	clear_screen()
	add_child(main_scene.instantiate())

