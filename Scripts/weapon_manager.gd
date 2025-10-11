extends Node3D
const RAY := preload("uid://be2ixbaa5oacl")
const FIRE_RATE := 0.2
const RAY_LENGTH := 30.0
var fire_timer := 0.0
var player : CharacterBody3D
func fire() -> void:
	if not player:
		return
	if fire_timer <= 0.0:
		fire_timer = FIRE_RATE
		var new_ray = RAY.instantiate()
		get_tree().current_scene.add_child(new_ray)
		var points : Array[Vector3]
		points.append(player.global_position)
		points.append(player.global_position + player.pointing_vector * RAY_LENGTH)
		new_ray.update_points(points)
		
func _physics_process(delta: float) -> void:
	if fire_timer > 0.0:
		fire_timer = maxf(fire_timer - delta, 0.0)
	
