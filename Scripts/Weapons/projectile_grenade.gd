extends Area3D
const EXPLOSION := preload("uid://bp3mahismsqco")
const GRAVITY := 6.0
@export var lifetime_total := 1.0
var velocity := Vector3.ZERO
var lifetime := lifetime_total
var attached = false
func _physics_process(delta: float) -> void:
	lifetime -= delta
	if lifetime <= 0.0:
		grenade_explode()
	if attached:
		return
	velocity.y -= GRAVITY*delta
	position += velocity*delta
func _on_area_entered(area: Node3D) -> void:
	var collider : Node3D = area.get_parent()
	if not collider.is_in_group("Enemy"):
		return
	set_attached()
	var original_position = global_position
	get_parent().remove_child(self)
	collider.add_child(self)
	global_position = original_position
func grenade_explode() -> void:
	var explosion : Area3D = EXPLOSION.instantiate()
	get_tree().current_scene.add_child(explosion)
	explosion.global_position = global_position
	explosion.affect_enemy(true)
	explosion.set_damage(8.0)
	explosion.explode()
	queue_free()
func set_lifetime(life : float)->void:
	lifetime_total = life
	lifetime = life
func _on_body_entered(body: Node3D) -> void:
	set_attached()
func set_attached()->void:
	attached = true
	set_lifetime(0.4)
