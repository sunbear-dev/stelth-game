extends Node2D

@export var tile_map: TileMap
@export var vision : VisionComponent
@onready var movement_component = $MovementComponent
var finished_walking = true
var move_range = 5
var cone : Polygon2D

var rng = RandomNumberGenerator.new()

var facing = DIRECTION.NORTH
enum DIRECTION	{NORTH, EAST, SOUTH, WEST}
var facing_dict = {
	DIRECTION.NORTH : Vector2.UP, 
	DIRECTION.EAST: Vector2.RIGHT, 
	DIRECTION.WEST: Vector2.LEFT, 
	DIRECTION.SOUTH: Vector2.DOWN
	}

signal player_spotted

func _ready():
	vision.create_vision_cone(self)
	cone = create_cone()
	movement_component.create_path_line()

func _process(_delta):
	facing = _determine_direction()
	vision.rotate_rays(facing_dict[facing])
	if vision.spot_player():
		player_spotted.emit()
	update_cone()

func update_cone():
	var shape = vision.draw_cone(self)
	cone.set_polygon(PackedVector2Array(shape))
	cone.position = Vector2(0,0)


func create_cone():
	var shape = vision.draw_cone(self)
	var poly = Polygon2D.new()
	poly.set_polygon(PackedVector2Array(shape))
	poly.color = Color("red")
	poly.modulate.a = 0.5
	add_child(poly)

	return poly

func next_goal() -> Vector2:
	var allowed_tiles = tile_map.allowed_paths(self.move_range, self.global_position)
	var _next_goal = allowed_tiles[rng.randf_range(0, allowed_tiles.size())]
	return _next_goal
	

func move():
	finished_walking = false
	movement_component.clear_path_lines()
	movement_component.start_moving()

func set_next_path():
	var path = tile_map.navigate_enemy(global_position, next_goal())
	movement_component.set_walk_path(path)
	movement_component.update_path_line()


func _on_movement_component_finished_walking():
	finished_walking = true


func _determine_direction() -> DIRECTION:
	var direction = movement_component.get_direction()
	if direction == Vector2(1,0):
		return DIRECTION.EAST
	if direction == Vector2(-1,0):
		return DIRECTION.WEST
	if direction == Vector2(0,-1):
		return DIRECTION.NORTH
	if direction == Vector2(0,1):
		return DIRECTION.SOUTH
	return facing
