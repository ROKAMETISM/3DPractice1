extends Node3D
const PROJECTILE_PLASMA := preload("uid://biq8247xoej2a")
const FIRE_RATE := 0.1
const RANGE := 35.0
const PROJECTILE_SPEED := 15.0
const BASE_DAMAGE := 5.0
const DAMAGE_SPREAD := 1.0
const SPREAD_ANGLE := deg_to_rad(2.5)
const WEAPON_NAME := "PlasmaRifle"
var _fire_timer := 0.0
var pointing_vector := Vector3.ONE
var adjusted_rotation := Vector2.ZERO
@onready var raycast := $RayCast3D
func fire_main_repeated() -> void:
	_plasma_rifle_fire()
	return
func fire_main_pressed() -> void:
	return
func fire_main_released() -> void:
	return
func _physics_process(delta: float) -> void:
	if _fire_timer > 0.0:
		_fire_timer = maxf(_fire_timer - delta, 0.0)
func _plasma_rifle_fire() -> void:
	if _fire_timer > 0.0:
		return
	_fire_timer = FIRE_RATE
	var aim_vector : Vector3 = _get_aim_with_spread(adjusted_rotation, SPREAD_ANGLE)
	var projectile : Area3D = PROJECTILE_PLASMA.instantiate()
	get_tree().current_scene.add_child(projectile)
	projectile.global_position = global_position 
	projectile.velocity = aim_vector.normalized()*PROJECTILE_SPEED
	projectile.set_lifetime(RANGE / PROJECTILE_SPEED)
func _get_aim_with_spread(original_rotation:Vector2, spread:float)->Vector3:
	var result_vector := Vector3.FORWARD
	var spread_rotation := Vector2(sqrt(randf())*spread, 0.0).rotated(randf_range(0.0, 2*PI))
	var result_rotation := original_rotation + spread_rotation
	result_vector = result_vector.rotated(Vector3.RIGHT, result_rotation.x)
	result_vector = result_vector.rotated(Vector3.UP, result_rotation.y)
	return result_vector
