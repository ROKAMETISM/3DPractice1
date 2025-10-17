extends Area3D
const HITPARTICLE := preload("uid://pm7lgpgx10gl")
var velocity := Vector3.ZERO
var _damage := 2.5
var _lifetime := 1.0
func _physics_process(delta: float) -> void:
	_lifetime -= delta
	if _lifetime <= 0.0:
		queue_free()
	position += velocity * delta
func _on_area_entered(area: Node3D) -> void:
	#check if the collider is an enemy
	var collider : Object = area.get_parent()
	if collider.is_in_group("Enemy"):
		collider.take_damage(_damage)
	on_hit()
func init(lifetime : float, damage:float)->void:
	_lifetime = lifetime
	_damage = damage
func on_hit()->void:
	print("Projectile Plasma:%.2f, %.2f"%[velocity.length(),_damage])
	var hit_particle : MeshInstance3D = HITPARTICLE.instantiate()
	get_tree().current_scene.add_child(hit_particle)
	hit_particle.global_position = global_position
	hit_particle.set_direction(-velocity.normalized())
	queue_free()
func _on_body_entered(body: Node3D) -> void:
	on_hit()
