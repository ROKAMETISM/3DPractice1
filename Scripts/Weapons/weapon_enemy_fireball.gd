extends Weapon
const FIREBALL := preload("uid://dt4t5dl6eh45c")
var aim:Vector3 = Vector3.FORWARD
func fire_main_pressed() -> void:
	super()
	if _fireball():
		pass
func _fireball() -> bool:
	var projectile_damage := base_damage+randf_range(-1.0,1.0)*damage_spread
	fire_projectile(FIREBALL, projectile_damage, aim, 10.0)
	return true
