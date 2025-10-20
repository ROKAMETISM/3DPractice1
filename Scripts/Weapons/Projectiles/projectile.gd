class_name Projectile extends Area3D
@export var hit_enemy := true
@export var hit_player := false
var _velocity := Vector3.ZERO
var _damage := 2.5
var _lifetime := 1.00
var _source:Node3D=null
func _ready() -> void:
	collision_layer = 0b0
	collision_mask = 0b0
	#collision mask 2 for hitting environment. Otherwise go through the environment.
	set_collision_mask_value(2, true)
	if hit_enemy:
		set_collision_mask_value(5, true)
	if hit_player:
		set_collision_layer_value(3, true)
func _physics_process(delta: float) -> void:
	_lifetime -= delta
	if _lifetime <= 0.0:
		queue_free()
	position += _velocity * delta
func _on_area_entered(area: Node3D) -> void:
	if not get_tree():
		return
	if area is EntityComponent:
		if area.is_enemy:
			area.take_hit(_source, _damage)
	_on_hit()
func _on_body_entered(_body: Node3D) -> void:
	if not get_tree():
		return
	_on_hit()
func init(velocity:Vector3, lifetime : float, damage:float, source:Node3D)->void:
	_velocity = velocity
	_lifetime = lifetime
	_damage = damage
	_source = source
func _on_hit()->void:
	queue_free()
