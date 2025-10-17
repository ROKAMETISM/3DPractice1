extends Weapon
const PROJECTILE_PLASMA := preload("uid://biq8247xoej2a")
func fire_main_repeated() -> void:
	super()
	_plasma_rifle_fire()
func _plasma_rifle_fire() -> bool:
	if _main_fire_timer > 0.0:
		return false
	_main_fire_timer = main_fire_rate
	var aim_vector : Vector3 = _get_aim_with_spread(_adjusted_rotation, _spread_angle)
	var projectile : Area3D = PROJECTILE_PLASMA.instantiate()
	get_tree().current_scene.add_child(projectile)
	projectile.global_position = global_position 
	projectile.velocity = aim_vector.normalized()*projectile_speed
	projectile.set_lifetime(weapon_range / projectile_speed)
	return true
