extends Node3D
@export var main_fire_rate := 1.0
@export var special_fire_rate := 1.0
@export var range := 30.0
@export var base_damage := 5.0
@export var damage_spread := 1.0
@export var spread_angle := deg_to_rad(1.0)
@export var weapon_name := "WeaponName"
var _main_fire_timer := 0.
var _special_fire_timer := 0.0
var _pointing_vector := Vector3.ONE
var _adjusted_rotation := Vector2.ZERO
@onready var raycast := $RayCast3D
var _is_fire_main_pressed := false
var _is_fire_special_pressed := false
func fire_main_repeated() -> void:
	pass
func fire_main_pressed() -> void:
	_is_fire_main_pressed = true
	pass
func fire_main_released() -> void:
	_is_fire_main_pressed = false
	pass
func fire_special_repeated() -> void:
	pass
func fire_special_pressed() -> void:
	_is_fire_special_pressed = true
	pass
func fire_special_released() -> void:
	_is_fire_special_pressed = false
	pass
func _physics_process(delta: float) -> void:
	if _main_fire_timer > 0.0:
		_main_fire_timer = maxf(_main_fire_timer - delta, 0.0)
	if _special_fire_timer > 0.0:
		_special_fire_timer = maxf(_special_fire_timer - delta, 0.0)
	if _is_fire_main_pressed:
		fire_main_repeated()
	if _is_fire_special_pressed:
		fire_special_repeated()
func _get_aim_with_spread(original_rotation:Vector2, spread:float)->Vector3:
	var result_vector := Vector3.FORWARD
	var spread_rotation := Vector2(sqrt(randf())*spread, 0.0).rotated(randf_range(0.0, 2*PI))
	var result_rotation := original_rotation + spread_rotation
	result_vector = result_vector.rotated(Vector3.RIGHT, result_rotation.x)
	result_vector = result_vector.rotated(Vector3.UP, result_rotation.y)
	return result_vector
func reset() -> void:
	_main_fire_timer = 0.0
	_special_fire_timer = 0.0
	_is_fire_main_pressed = false
	_is_fire_special_pressed = false
