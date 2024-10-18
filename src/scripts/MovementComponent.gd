extends Node2D

var _walk_path : Array[Vector2i]
@export var entity : Node2D
var _is_moving = false
signal finished_walking
var direction : Vector2
var path_line : Line2D

func _process(_delta):
	if _walk_path.is_empty():
		if _is_moving:
			emit_signal("finished_walking")
		_is_moving = false
	if _is_moving:
		var target_position = entity.tile_map.map_to_local(_walk_path.front())
		direction = _walk_path.front() - entity.tile_map.local_to_map(entity.global_position)
		entity.global_position = entity.global_position.move_toward(target_position, 1)
		if entity.global_position == target_position:
			_walk_path.pop_front()
			
func get_direction():
	return direction

func set_walk_path(path):
	_walk_path = path

func start_moving():
	_is_moving = true

func show_ava_tiles(available_tiles):
	for x in available_tiles:
		entity.tile_map.set_cell(1, x, 0, Vector2(2,5))

func hide_ava_tiles(available_tiles):
	for x in available_tiles:
		entity.tile_map.set_cell(1, x, -1, Vector2(0,0))
		
func create_path_line():
	path_line = Line2D.new()
	path_line.position = Vector2(0,0)
	path_line.default_color = Color("red")  
	path_line.width = 5  	
	update_path_line()
	add_child(path_line)

func update_path_line():
	path_line.add_point(entity.to_local(entity.tile_map.snap_to_map(entity.position)))
	for point in _walk_path:
		path_line.add_point(entity.to_local(entity.tile_map.map_to_local(point)))

func clear_path_lines():
	path_line.clear_points()
