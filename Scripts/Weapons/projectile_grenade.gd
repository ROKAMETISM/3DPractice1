extends Area3D
const HITPARTICLE := preload("uid://pm7lgpgx10gl")
const EXPLOSION := preload("uid://bp3mahismsqco")
const GRAVITY := 9.8
@export var lifetime_total := 1.0
var base_damage := 2.5
var damage_spread := 0.5
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
	#check if the collider is an enemy
	print("Collsiion")
	var collider : Object = area.get_parent()
	if collider.is_in_group("Enemy"):
		var damage := base_damage
		damage += randf_range(-1.0, 1.0)*damage_spread
		collider.take_damage(damage)
	var hit_particle : MeshInstance3D = HITPARTICLE.instantiate()
	get_tree().current_scene.add_child(hit_particle)
	hit_particle.global_position = global_position
	hit_particle.set_direction(-velocity.normalized())
	grenade_explode()
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
	attached = true
