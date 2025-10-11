extends Node3D
const RAY := preload("uid://be2ixbaa5oacl")
const FIRE_RATE := 0.2
const PISTOL_RANGE := 30.0
var fire_timer := 0.0
var player : CharacterBody3D
@onready var raycast := $RayCast3D
func fire() -> void:
	if not player:
		return
	if fire_timer > 0.0:
		return
	fire_timer = FIRE_RATE
	raycast.target_position = player.pointing_vector * PISTOL_RANGE
	raycast.force_raycast_update()
	var points : Array[Vector3]
	var new_ray = RAY.instantiate()
	points.append(global_position)
	get_tree().current_scene.add_child(new_ray)
	if raycast.is_colliding():
		var ray_endpoint : Vector3 = raycast.get_collision_point()
		points.append(ray_endpoint)
	else:
		points.append(global_position+raycast.target_position)
	new_ray.update_points(points)
func _physics_process(delta: float) -> void:
	if fire_timer > 0.0:
		fire_timer = maxf(fire_timer - delta, 0.0)
