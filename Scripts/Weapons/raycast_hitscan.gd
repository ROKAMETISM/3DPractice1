class_name RaycastHitscan extends RayCast3D
const RAY := preload("uid://be2ixbaa5oacl")
var ray_endpoint := position
var collision_normal := Vector3.ONE
var damage := 1.0
func _ready() -> void:
	enabled = false
	set_collision_mask_value(1, false)
	set_collision_mask_value(2, true)
	set_collision_mask_value(5, true)
	collide_with_areas = true
func hitscan(target_position_relative : Vector3)->Object:
	var points : Array[Vector3]
	var new_ray = RAY.instantiate()
	points.append(global_position)
	get_tree().current_scene.add_child(new_ray)
	target_position = target_position_relative
	force_raycast_update()
	ray_endpoint = global_position+target_position_relative
	#An Enemy or an Environment has been hit!
	if is_colliding():
		collision_normal=get_collision_normal()
		ray_endpoint = get_collision_point()
		var collider = get_collider().get_parent()
		if collider.is_in_group("Enemy"):
			collider.take_damage(damage)
	points.append(ray_endpoint)
	new_ray.update_points(points)
	return get_collider()
func set_damage(new_damage:float)->void:damage=new_damage
