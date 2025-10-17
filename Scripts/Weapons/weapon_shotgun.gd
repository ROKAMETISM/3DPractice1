extends Weapon
const RAY := preload("uid://be2ixbaa5oacl")
const HITPARTICLE := preload("uid://pm7lgpgx10gl")
const PROJECTILE_GRENADE := preload("uid://cqfxv0v35oiyu")
@export var pellets := 8
func fire_main_repeated() -> void:
	super()
	_shotgun_fire()
func fire_special_pressed() -> void:
	super()
	_grenade_fire()
func _shotgun_fire() -> void:
	if _main_fire_timer > 0.0:
		return
	_main_fire_timer = main_fire_rate
	for i in range(0, pellets):
		_fire_single_pellet()
func _fire_single_pellet() -> void:
	var points : Array[Vector3]
	var new_ray = RAY.instantiate()
	points.append(global_position)
	get_tree().current_scene.add_child(new_ray)
	var aim_vector : Vector3 = _get_aim_with_spread(_adjusted_rotation, _spread_angle)
	raycast.target_position = aim_vector * weapon_range
	raycast.force_raycast_update()
	if raycast.is_colliding():
		#An Enemy or an Environment has been hit!
		var ray_endpoint : Vector3 = raycast.get_collision_point()
		points.append(ray_endpoint)
		var hit_particle : MeshInstance3D = HITPARTICLE.instantiate()
		get_tree().current_scene.add_child(hit_particle)
		hit_particle.global_position = ray_endpoint
		hit_particle.set_direction(raycast.get_collision_normal())
		#check if the collider is an enemy
		var collider : Object = raycast.get_collider().get_parent()
		if collider.is_in_group("Enemy"):
			var damage := base_damage
			damage += randf_range(-1.0, 1.0)*damage_spread
			collider.take_damage(damage)
	else:
		#out of weapon_range
		points.append(global_position+raycast.target_position)
	new_ray.update_points(points)
func _grenade_fire()->void:
	var aim_vector : Vector3 = _get_aim_with_spread(_adjusted_rotation, 0.0)
	var projectile : Area3D = PROJECTILE_GRENADE.instantiate()
	get_tree().current_scene.add_child(projectile)
	projectile.global_position = global_position 
	projectile.velocity = aim_vector.normalized()*projectile_speed
	projectile.set_lifetime(1.0)
