class_name Weapon
extends Node3D
enum AmmoType {
	Inf,
	ShotgunShell,
	Plasma,
	Rocket
}
@export var main_fire_rate := 1.0
@export var special_fire_rate := 1.0
@export var weapon_range := 30.0
@export var projectile_speed := 15.0
@export var base_damage := 5.0
@export var damage_spread := 1.0
@export var spread_angle := 1.0
@export var recoil := 1.0
@export var weapon_name := "WeaponName"
@export var ammo_type : AmmoType
##Recoil in degrees angle
@export var weapon_vis_text : Texture2D = null
var _weapon_manager : WeaponManager
var _main_fire_timer := 0.
var _special_fire_timer := 0.0
var _pointing_vector := Vector3.ONE
var _adjusted_rotation := Vector2.ZERO
var _spread_angle := deg_to_rad(spread_angle)
var _is_fire_main_pressed := false
var _is_fire_special_pressed := false
##recoil amount in radians
signal weapon_recoil(angle : float)
func _ready() -> void:
	_spread_angle = deg_to_rad(spread_angle)
func fire_main_repeated() -> void:
	pass
func fire_main_pressed() -> void:
	_is_fire_main_pressed = true
func fire_main_released() -> void:
	_is_fire_main_pressed = false
func fire_special_repeated() -> void:
	pass
func fire_special_pressed() -> void:
	_is_fire_special_pressed = true
func fire_special_released() -> void:
	_is_fire_special_pressed = false
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
func set_direction(pointing_vector:Vector3, adjusted_rotation:Vector2)->void:
	_pointing_vector = pointing_vector
	_adjusted_rotation = adjusted_rotation
func get_spread_angle_rad()->float:
	return deg_to_rad(spread_angle)
func get_weapon_name()->String:
	return weapon_name
func apply_recoil()->void:
	weapon_recoil.emit(deg_to_rad(recoil))
##Instantiate and initialize a given projectile. direction must be normalized.
func fire_projectile(projectile_scene:PackedScene, damage:float,direction:Vector3,lifetime:float)->Node3D:
	var projectile : Node3D = projectile_scene.instantiate()
	get_tree().current_scene.add_child(projectile)
	projectile.init(lifetime, damage)
	projectile.global_position = global_position 
	projectile.velocity = direction*projectile_speed+get_parent().player.velocity
	return projectile
func ammo_is_available(min_amount:int)->bool:
	if not _weapon_manager:
		return false
	var current_ammo : int = _weapon_manager.get_current_ammo()
	return current_ammo >= min_amount
