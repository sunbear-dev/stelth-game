extends Node2D
class_name TurnManager

@export var tile_map : TileMap
@export var player : Player
@export var enemy_group : Node2D
var enemies = []
var _enemies_have_moved = false
var _has_moved : bool = false
var _has_attacked : bool
var player_turn: bool = true

func _ready():
	enemies = enemy_group.get_children()

func _physics_process(delta):
	if player_turn:
		_player_turn()
	else:
		_enemy_turn()


func _player_turn():
	if !player.can_act:
		return
	if _has_moved:
		return
	var allowed_tiles = tile_map.allowed_tiles(player.move_range, player.global_position)
	player.show_tiles(allowed_tiles)
	if Input.is_action_just_pressed("move"):
			if tile_map.legal_move(allowed_tiles):
				var path = tile_map.navigate_player(player.global_position, get_global_mouse_position())
				tile_map.set_cell(1, path.back(), 1, Vector2i(7,9))
				player.move(path)
				player.hide_tiles(allowed_tiles)
				_has_moved = true

func _enemy_turn():
	if !_enemies_have_moved:
		for e in enemies:
			var next_goal = e.next_goal()
			var path = tile_map.navigate_enemy(e.global_position, next_goal)
			e.move(path)
			_enemies_have_moved = true
	var done_moving = true
	for e in enemies:
		if !e.finished_walking:
			return
	_enemies_have_moved = false
	player_turn = true


func _on_end_turn_button_pressed():
	player_turn = false
	_has_moved = false
	_has_attacked = false
	
