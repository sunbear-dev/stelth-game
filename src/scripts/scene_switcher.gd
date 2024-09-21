extends Control

@onready var game_over_screen = load("res://src/scenes/game_over_screen.tscn")
@onready var game_scene = load("res://src/scenes/game.tscn")
@onready var win_scene = load("res://src/scenes/win_screen.tscn")

var level

func game_over():
	get_node("Game").queue_free()
	add_child(game_over_screen.instantiate())
	

func game_on():
	get_node("game_over_screen").queue_free()
	add_child(game_scene.instantiate())

func you_win():
	get_node("Game").queue_free()
	add_child(win_scene.instantiate())
