extends Control
class_name SceneSwitcher
@onready var game_over_screen = load("res://src/scenes/game_over_screen.tscn")
@onready var lev_man = load("res://src/scenes/level_manager.tscn")
@onready var win_scene = load("res://src/scenes/win_screen.tscn")
@export var canvas : CanvasLayer
var level



func clear_screen():
	for x in get_children():
		if x != canvas:
			x.queue_free()

func game_over():
	clear_screen()
	add_child(game_over_screen.instantiate())

func add_level_manager() -> LevelManager:
	var lev_child = lev_man.instantiate()
	lev_child.init(self)
	add_child(lev_child)
	return lev_child	

func next_level():
	clear_screen()
	var lev = add_level_manager()
	if lev.is_last_level(level):
		you_win()
	lev.load_next_level(level)

func retry():
	clear_screen()
	var lev = add_level_manager()
	lev.load_level(level)

func you_win():
	clear_screen()
	add_child(win_scene.instantiate())
