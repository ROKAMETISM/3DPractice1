extends Projectile
const HITPARTICLE := preload("uid://pm7lgpgx10gl")
func on_hit()->void:
	var hit_particle : MeshInstance3D = HITPARTICLE.instantiate()
	get_tree().current_scene.add_child(hit_particle)
	hit_particle.global_position = global_position
	hit_particle.set_direction(-_velocity.normalized())
	queue_free()
