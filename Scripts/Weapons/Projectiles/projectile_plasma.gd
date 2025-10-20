extends Area3D
const HITPARTICLE := preload("uid://pm7lgpgx10gl")
var velocity := Vector3.ZERO
var _damage := 2.5
var _lifetime := 1.00
var source:Node3D=null
func _physics_process(delta: float) -> void:
	_lifetime -= delta
	if _lifetime <= 0.0:
		queue_free()
	position += velocity * delta
func _on_area_entered(area: Node3D) -> void:
	if not get_tree():
		return
	if area is EntityComponent:
		if area.is_enemy:
			area.take_hit(source, _damage)
	on_hit()
func _on_body_entered(body: Node3D) -> void:
	if not get_tree():
		return
	on_hit()
func init(lifetime : float, damage:float)->void:
	_lifetime = lifetime
	_damage = damage
func on_hit()->void:
	var hit_particle : MeshInstance3D = HITPARTICLE.instantiate()
	get_tree().current_scene.add_child(hit_particle)
	hit_particle.global_position = global_position
	hit_particle.set_direction(-velocity.normalized())
	queue_free()
