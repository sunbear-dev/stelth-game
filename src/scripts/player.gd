extends Node2D
class_name Player

@export var tile_map : TileMap
var can_act = true
@onready var movement_component = $MovementComponent
var move_range = 5
var move_range_max = 5
signal win


func move(path):
	move_range -= path.size()
	movement_component.set_walk_path(path)
	movement_component.start_moving()
	can_act = false

func finished_movement():
	var tile = tile_map.get_cell_atlas_coords(0, tile_map.local_to_map(global_position))
	if tile == Vector2i(1,5):
		win.emit()		
	can_act = true


func show_tiles(av_tiles):
	movement_component.show_ava_tiles(av_tiles)

func hide_tiles(av_tiles):
	movement_component.hide_ava_tiles(av_tiles)		


func _on_movement_component_finished_walking():
	finished_movement()
