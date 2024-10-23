extends Node2D
class_name  LevelManager
var level = 0
var levels = ["res://src/levels/level1.tscn", "res://src/levels/level2.tscn", "res://src/levels/level3.tscn"]
var level_scene
@onready var spotted_screen = load("res://src/scenes/spotted_screen.tscn")
@export var scene_switcher : SceneSwitcher
signal key_press

func _unhandled_key_input(event):
	if event.is_pressed():
		key_press.emit()



func is_last_level():
	if level + 1 > levels.size():
		return true
	return false

func next_level():
	increase_level()
	load_level()

func set_level(lv):
	if lv < levels.size():
		level = lv

func increase_level():
	if level + 1 <= levels.size():
		level += 1
		
func free_level():
	if level_scene != null:
		level_scene.queue_free()

func load_level():
	free_level()
	var level_load = load(levels[level])
	level_scene = level_load.instantiate()
	level_scene.init(self)
	self.add_child(level_scene)


func level_success():
	increase_level()
	if is_last_level():
		scene_switcher.all_levels_complete()
	else:
		scene_switcher.you_win()
		
func level_fail():
	level_scene.turn_manager.pause()
	level_scene.add_child(spotted_screen.instantiate())
	await key_press
	scene_switcher.game_over()

	
