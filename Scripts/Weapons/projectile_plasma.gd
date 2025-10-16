extends Area3D
const HITPARTICLE := preload("uid://pm7lgpgx10gl")
@export var lifetime_total := 1.0
var base_damage := 5.0
var damage_spread := 1.0
var velocity := Vector3.ZERO
var lifetime := lifetime_total
func _physics_process(delta: float) -> void:
	lifetime -= delta
	if lifetime <= 0.0:
		queue_free()
	position += velocity * delta
func _on_body_entered(body: Node3D) -> void:
	#check if the collider is an enemy
	var collider : Object = body.get_parent()
	if collider.is_in_group("Enemy"):
		var damage := base_damage
		damage += randf_range(-1.0, 1.0)*damage_spread
		collider.take_damage(damage)
	var hit_particle : MeshInstance3D = HITPARTICLE.instantiate()
	get_tree().current_scene.add_child(hit_particle)
	hit_particle.global_position = global_position
	hit_particle.set_direction(-velocity)
	queue_free()
func set_lifetime(life : float)->void:
	lifetime_total = life
	lifetime = life
