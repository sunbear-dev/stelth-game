extends Node2D

@onready var level_manag = $LevelManager

func _on_guard_player_spotted():
	get_parent().level = level_manag.level
	get_parent().game_over()
	

func _on_player_win():
	get_parent().you_win()
