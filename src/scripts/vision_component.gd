extends Node2D
class_name VisionComponent

var ray_array : Array[RayCast2D] = []
var view_distance = 70
var view_angle = 30.0 #DEG
var nr_of_rays = 8.0
var angle_between_rays : float = view_angle/nr_of_rays

func create_vision_cone(entity):
	for x in nr_of_rays:
		var ray = RayCast2D.new()
		var angle = angle_between_rays *  (-(nr_of_rays / 2) + x)
		ray.target_position = Vector2.UP.rotated(deg_to_rad(angle)) * view_distance
		ray_array.append(ray)
		ray.collide_with_areas = true
		entity.add_child(ray)		

func draw_cone(caller):
	var shape = []
	for ray in ray_array:
		if ray.is_colliding():
			shape.append(caller.to_local(ray.get_collision_point()))
		else:
			shape.append(caller.to_local(caller.to_global(ray.target_position)))
	shape.append(caller.to_local(caller.global_position))
	return shape

func spot_player() -> bool:
	for ray in ray_array:
		if ray.is_colliding():
			print(ray.get_collider().name)
			var voll = ray.get_collider()
			if voll.name == "HideBox":
				return true
	return false

func rotate_rays(dir_vec):
	for x in nr_of_rays:
		var angle = angle_between_rays *  (-(nr_of_rays / 2) + x)
		ray_array[x].target_position = dir_vec.rotated(deg_to_rad(angle)) * view_distance
		
		
	
	
