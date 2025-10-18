extends Weapon
const HITPARTICLE := preload("uid://pm7lgpgx10gl")
@onready var hitscan := $RaycastHitscan
func fire_main_pressed() -> void:
	super()
	if not ammo_is_available(1):
		return
	if _pistol_fire():
		use_ammo(1)
		apply_recoil()
func _pistol_fire() -> bool:
	if _main_fire_timer > 0.0:
		return false
	_main_fire_timer = main_fire_rate
	var aim_vector : Vector3 = _get_aim_with_spread(_adjusted_rotation, _spread_angle).normalized()
	hitscan.damage = base_damage + randf_range(-1.0, 1.0)*damage_spread
	var collider = hitscan.hitscan(aim_vector * weapon_range)
	if collider:
		var hit_particle : MeshInstance3D = HITPARTICLE.instantiate()
		get_tree().current_scene.add_child(hit_particle)
		hit_particle.global_position = hitscan.ray_endpoint
		hit_particle.set_direction(hitscan.collision_normal)
	return true
