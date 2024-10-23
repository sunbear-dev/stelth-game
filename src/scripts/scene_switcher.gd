extends Control
class_name SceneSwitcher
@onready var game_over_screen = load("res://src/scenes/game_over_screen.tscn")
@onready var win_scene = load("res://src/scenes/win_screen.tscn")
@onready var main_scene = load("res://src/scenes/main_menu.tscn")
@onready var level_picker = load("res://src/scenes/level_picker.tscn")
@onready var complete_screen = load("res://src/scenes/complete_screen.tscn")
@onready var lev_man = $LevelManager

func clear_screen():
	lev_man.free_level()
	for x in get_children():
		if x != lev_man:
			x.queue_free()

func levels_menu():
	clear_screen()
	add_child(level_picker.instantiate())	

func set_level(level):
	lev_man.set_level(level-1)
	
func game_over():
	clear_screen()
	add_child(game_over_screen.instantiate())


func load_level():
	clear_screen()
	lev_man.load_level()

func all_levels_complete():
	clear_screen()
	add_child(complete_screen.instantiate())
	
func you_win():
	clear_screen()
	add_child(win_scene.instantiate())
	
func main_menu():
	clear_screen()
	add_child(main_scene.instantiate())

