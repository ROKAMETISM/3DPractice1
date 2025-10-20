extends Area3D
const EXPLOSION := preload("uid://bp3mahismsqco")
@export var lifetime_total := 1.0
var velocity := Vector3.ZERO
var _damage := 2.5
var _lifetime := 1.0
func _physics_process(delta: float) -> void:
	_lifetime -= delta
	if _lifetime <= 0.0:
		rocket_explode()
	position += velocity*delta
func _on_area_entered(area: Node3D) -> void:
	rocket_explode()
func _on_body_entered(body: Node3D) -> void:
	rocket_explode()
func rocket_explode() -> void:
	var explosion : Area3D = EXPLOSION.instantiate()
	get_tree().current_scene.add_child(explosion)
	explosion.global_position = global_position
	explosion.affect_enemy(true)
	explosion.set_damage(_damage)
	explosion.explode()
	queue_free()
func init(lifetime : float, damage:float)->void:
	_lifetime = lifetime
	_damage = damage
