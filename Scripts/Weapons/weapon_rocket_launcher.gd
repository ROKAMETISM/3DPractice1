extends Weapon
const ROCKET := preload("uid://db48pqrlchd3n")
func fire_main_repeated() -> void:
	super()
	if not ammo_is_available(1):
		return
	if _fire_single_rocket():
		use_ammo(1)
		apply_recoil()
func _fire_single_rocket() -> bool:
	if _main_fire_timer > 0.0:
		return false
	_main_fire_timer = main_fire_rate
	var aim_vector : Vector3 = _get_aim_with_spread(_adjusted_rotation, _spread_angle).normalized()
	var projectile_damage := base_damage+randf_range(-1.0,1.0)*damage_spread
	fire_projectile(ROCKET, projectile_damage, aim_vector, 15.0)
	return true
