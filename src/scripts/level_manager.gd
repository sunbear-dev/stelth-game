extends Node2D
class_name  LevelManager
var global_level = 0
var levels = ["res://src/levels/level1.tscn"]
@onready var level_scene = $Level
@export var scene_switcher : SceneSwitcher

	
func init(sw):
	scene_switcher = sw

func is_last_level(level):
	if level + 1 > levels.length():
		return true
	return false

func load_next_level(level):
	free_level()
	load_level(level + 1)
		
func free_level():
	if level_scene != null:
		level_scene.queue_free()

func load_level(level):
	free_level()
	var level_load = load(levels[level])
	level_scene = level_load.instantiate()
	level_scene.init(self)
	self.add_child(level_scene)


func level_success():
	global_level += 1
	scene_switcher.level = global_level
	scene_switcher.you_win()
		
func level_fail():
	scene_switcher.level = global_level
	scene_switcher.game_over()



func _on_end_turn_button_pressed():
	level_scene.turn_end()
	
