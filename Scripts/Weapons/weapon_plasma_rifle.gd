extends Weapon
const PROJECTILE_PLASMA := preload("uid://biq8247xoej2a")
func fire_main_repeated() -> void:
	super()
	_plasma_rifle_fire()
func _plasma_rifle_fire() -> bool:
	if _main_fire_timer > 0.0:
		return false
	_main_fire_timer = main_fire_rate
	var aim_vector : Vector3 = _get_aim_with_spread(_adjusted_rotation, _spread_angle).normalized()
	var projectile_damage := base_damage+randf_range(-1.0,1.0)*damage_spread
	var projectile : Area3D = fire_projectile(PROJECTILE_PLASMA, projectile_damage, aim_vector, weapon_range/projectile_speed)
	return true
