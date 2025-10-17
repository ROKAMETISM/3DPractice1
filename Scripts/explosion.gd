extends Area3D
@export var damage := 16.0
@export var range := 16.0
const EXPLOSION_LINGER := 0.5
func _ready() -> void:
	print("EXPLOSION")
func affect_player(flag : bool)->void:
	set_collision_mask_value(3, flag)
func affect_enemy(flag : bool)->void:
	set_collision_mask_value(5, flag)
func set_damage(explosion_damage:float)->void:
	damage = explosion_damage
	if damage > range:
		set_range(damage)
func set_range(explosion_range:float)->void:
	range = explosion_range
	$CollisionShape3D.shape.radius = range
func explode()->void:
	await get_tree().create_timer(0.05).timeout
	for area:Area3D in get_overlapping_areas():
		var distance = area.global_position - global_position
		area.get_parent().take_damage(damage - distance.length())
	monitorable = false
	monitoring = false
	await get_tree().create_timer(EXPLOSION_LINGER).timeout
	queue_free()
