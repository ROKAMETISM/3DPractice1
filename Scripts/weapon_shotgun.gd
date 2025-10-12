extends Node3D
const RAY := preload("uid://be2ixbaa5oacl")
const HITPARTICLE := preload("uid://pm7lgpgx10gl")
const FIRE_RATE := 0.8
const RANGE := 25.0
const BASE_DAMAGE := 4.0
const DAMAGE_SPREAD := 1.0
const PELLETS := 7
const SPREAD_ANGLE := deg_to_rad(5.9)
const WEAPON_NAME := "Shotgun"
var _fire_timer := 0.0
var pointing_vector := Vector3.ONE
var adjusted_rotation := Vector2.ZERO
@onready var raycast := $RayCast3D
func fire_main_repeated() -> void:
	pass
func fire_main_pressed() -> void:
	_shotgun_fire()
func fire_main_released() -> void:
	pass
func _physics_process(delta: float) -> void:
	if _fire_timer > 0.0:
		_fire_timer = maxf(_fire_timer - delta, 0.0)
func _shotgun_fire() -> void:
	if _fire_timer > 0.0:
		return
	_fire_timer = FIRE_RATE
	for i in range(0, PELLETS):
		_fire_single_pellet()
func _fire_single_pellet() -> void:
	raycast.target_position = pointing_vector * RANGE
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
