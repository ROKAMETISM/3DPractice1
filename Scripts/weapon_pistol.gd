extends Node3D
const RAY := preload("uid://be2ixbaa5oacl")
const HITPARTICLE := preload("uid://pm7lgpgx10gl")
const FIRE_RATE := 0.1
const RANGE := 30.0
const BASE_DAMAGE := 5.0
const DAMAGE_SPREAD := 1.0
const SPREAD_ANGLE := deg_to_rad(10.0)
const WEAPON_NAME := "Pistol"
var fire_timer := 0.0
var player : CharacterBody3D
@onready var raycast := $RayCast3D
func fire_main_repeated() -> void:
	_pistol_fire()
	pass
func fire_main_pressed() -> void:
	_pistol_fire()
	pass
func fire_main_released() -> void:
	pass
func _physics_process(delta: float) -> void:
	if fire_timer > 0.0:
		fire_timer = maxf(fire_timer - delta, 0.0)
func _pistol_fire() -> void:
	if not player:
		return
	if fire_timer > 0.0:
		return
	fire_timer = FIRE_RATE
	var aim_vector : Vector3 = _get_aim_with_spread(player.pointing_vector, SPREAD_ANGLE)
	raycast.target_position = aim_vector * RANGE
	raycast.force_raycast_update()
	var points : Array[Vector3]
	var new_ray = RAY.instantiate()
	points.append(global_position)
	get_tree().current_scene.add_child(new_ray)
	if raycast.is_colliding():
		#An Enemy or an Environment has been hit!
		var ray_endpoint : Vector3 = raycast.get_collision_point()
		points.append(ray_endpoint)
		var hit_particle : MeshInstance3D = HITPARTICLE.instantiate()
		get_tree().current_scene.add_child(hit_particle)
		hit_particle.global_position = ray_endpoint
		hit_particle.set_direction(raycast.get_collision_normal())
		#check if the collider is an enemy
		var collider : Object = raycast.get_collider().get_parent()
		if collider.is_in_group("Enemy"):
			var damage := BASE_DAMAGE
			damage += randf_range(-1.0, 1.0)*DAMAGE_SPREAD
			collider.take_damage(damage)
	else:
		#out of range
		points.append(global_position+raycast.target_position)
	new_ray.update_points(points)
func _get_aim_with_spread(base_vector:Vector3, spread:float)->Vector3:
	var rotator := Vector3.ZERO
	var result_vector := base_vector
	if base_vector.y == 0.0:
		#keep y to 0, swap x and z
		rotator.x = base_vector.z
		rotator.z = -base_vector.x
	else:
		#set x to 0, swap y and z
		rotator.y = base_vector.z
		rotator.z = -base_vector.y
	rotator = rotator.normalized()
	rotator = rotator.rotated(base_vector, randf_range(0.0, 2*PI))
	result_vector = base_vector.rotated(rotator, randf_range(-spread, spread))
	return result_vector
