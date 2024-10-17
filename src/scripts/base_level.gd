extends Node2D

@onready var turn_manager = $TileMap/TurnManager
@export var level_manager : LevelManager


func turn_end():
	turn_manager.turn_end()

func _on_guard_player_spotted():
	level_manager.level_fail()

func init(lev_man):
	level_manager = lev_man

func _on_player_win():
	level_manager.level_success()
