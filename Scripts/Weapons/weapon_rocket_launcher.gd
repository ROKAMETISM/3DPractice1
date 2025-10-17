extends Weapon
const ROCKET := preload("uid://db48pqrlchd3n")
func fire_main_repeated() -> void:
	super()
	_fire_single_rocket()
	apply_recoil()
func _fire_single_rocket() -> void:
	if _main_fire_timer > 0.0:
		return
	_main_fire_timer = main_fire_rate
	var aim_vector : Vector3 = _get_aim_with_spread(_adjusted_rotation, _spread_angle)
	var projectile : Area3D = ROCKET.instantiate()
	get_tree().current_scene.add_child(projectile)
	projectile.global_position = global_position 
	projectile.velocity = aim_vector.normalized()*projectile_speed
	projectile.set_lifetime(15.0)
