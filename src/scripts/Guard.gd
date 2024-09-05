extends Node2D

@export var tile_map: TileMap
@export var vision : VisionComponent
@onready var movement_component = $MovementComponent
var finished_walking = true
var move_range = 5

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

func _process(delta):
	facing = _determine_direction()
	vision.rotate_rays(facing_dict[facing])
	if vision.spot_player():
		player_spotted.emit()

func next_goal() -> Vector2:
	var allowed_tiles = tile_map.allowed_tiles(self.move_range, self.global_position)
	var next_goal = allowed_tiles[rng.randf_range(0, allowed_tiles.size())]
	return next_goal
	

func move(path):
	finished_walking = false
	movement_component.set_walk_path(path)
	movement_component.start_moving()


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
