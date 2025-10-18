extends Area3D
@export var damage := 16.0
@export var explosion_range := 16.0
const EXPLOSION_LINGER := 0.8
const DAMAGE_PER_METER := 2.5
func affect_player(flag : bool)->void:
	set_collision_mask_value(3, flag)
func affect_enemy(flag : bool)->void:
	set_collision_mask_value(5, flag)
func set_damage(explosion_damage:float)->void:
	damage = explosion_damage
	set_range(damage)
func set_range(new_range:float)->void:
	explosion_range = new_range
	$CollisionShape3D.shape.radius = explosion_range
func explode()->void:
	await get_tree().create_timer(0.05).timeout
	for area:Area3D in get_overlapping_areas():
		var distance = area.global_position - global_position
		if area is EntityComponent:
			if area.is_enemy:
				area.take_hit(self, max(damage - distance.length()*DAMAGE_PER_METER, 0.0))
	monitorable = false
	monitoring = false
	await get_tree().create_timer(EXPLOSION_LINGER).timeout
	queue_free()
