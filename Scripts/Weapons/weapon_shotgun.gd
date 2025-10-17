extends Weapon
const RAY := preload("uid://be2ixbaa5oacl")
const HITPARTICLE := preload("uid://pm7lgpgx10gl")
const PROJECTILE_GRENADE := preload("uid://cqfxv0v35oiyu")
@onready var hitscan := $RaycastHitscan
@export var pellets := 8
@export var grenade_base_damage := 8.0
@export var grenade_damage_spread := 0.3
func fire_main_repeated() -> void:
	super()
	if _shotgun_fire():
		apply_recoil()
func fire_special_pressed() -> void:
	super()
	_grenade_fire()
func _shotgun_fire() -> bool:
	if _main_fire_timer > 0.0:
		return false
	_main_fire_timer = main_fire_rate
	for i in range(0, pellets):
		_fire_single_pellet()
	return true
func _fire_single_pellet() -> void:
	var aim_vector : Vector3 = _get_aim_with_spread(_adjusted_rotation, _spread_angle).normalized()
	hitscan.damage = base_damage + randf_range(-1.0, 1.0)*damage_spread
	var collider = hitscan.hitscan(aim_vector * weapon_range)
	if collider:
		var hit_particle : MeshInstance3D = HITPARTICLE.instantiate()
		get_tree().current_scene.add_child(hit_particle)
		hit_particle.global_position = hitscan.ray_endpoint
		hit_particle.set_direction(hitscan.collision_normal)
func _grenade_fire()->void:
	var aim_vector : Vector3 = _get_aim_with_spread(_adjusted_rotation, 0.0).normalized()
	var projectile_damage := grenade_base_damage+randf_range(-1.0,1.0)*grenade_damage_spread
	var projectile : Area3D = fire_projectile(PROJECTILE_GRENADE, projectile_damage, aim_vector, 2.0)
