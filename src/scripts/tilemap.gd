extends TileMap

var astar_grid: AStarGrid2D
# Called when the node enters the scene tree for the first time.
func _ready():
	astar_grid = AStarGrid2D.new()
	astar_grid.region = self.get_used_rect()
	astar_grid.cell_size = Vector2(self.rendering_quadrant_size, self.rendering_quadrant_size)
	astar_grid.diagonal_mode = AStarGrid2D.DIAGONAL_MODE_NEVER
	astar_grid.update()
	
	for x in get_used_rect().size.x:
		for y in get_used_rect().size.y:
			var tile_position = Vector2i(x + get_used_rect().position.x, y + get_used_rect().position.y)
			var tile_data = get_cell_tile_data(0, tile_position)
			if tile_data == null or !tile_data.get_custom_data("walkable"):
				astar_grid.set_point_solid(tile_position, true)
			
func navigate_player(from_pos: Vector2, to_pos : Vector2) -> Array[Vector2i]:
	var start_map_pos = self.local_to_map(from_pos)
	var end_map_pos = self.local_to_map(to_pos)
	var path = navigate(start_map_pos, end_map_pos)
	return path

func navigate_enemy(from_local_pos: Vector2, to_map_pos: Vector2) -> Array[Vector2i]:
	var from_map_pos = self.local_to_map(from_local_pos)
	return navigate(from_map_pos, to_map_pos)

func navigate(from_pos: Vector2, to_pos : Vector2) -> Array[Vector2i]:
	var path = astar_grid.get_id_path(from_pos, to_pos)
	return path.slice(1, path.size())

func allowed_tiles(distance, from_pos : Vector2):
	var allowed_paths = []
	var start_map_pos = self.local_to_map(from_pos)
	var minX = start_map_pos.x-distance
	var maxX = start_map_pos.x+distance
	var minY = start_map_pos.y-distance
	var maxY = start_map_pos.y + distance
	for x in range(minX, maxX):
		for y in range(minY, maxY):
			var end_pos = Vector2i(x, y)
			var path = navigate(start_map_pos, end_pos)
			if path.size() < distance and !path.is_empty():
				allowed_paths.append(end_pos)
	return allowed_paths

func legal_move(allowed_tiles):
	var clicked_tile = local_to_map(get_global_mouse_position())
	var tile = allowed_tiles.find(clicked_tile)
	if  tile != -1:
		return true
	return false
