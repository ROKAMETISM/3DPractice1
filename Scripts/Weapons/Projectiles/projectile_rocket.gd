extends Projectile
const EXPLOSION := preload("uid://bp3mahismsqco")
func _on_hit(_collider:Node3D) -> void:
	var explosion : Area3D = EXPLOSION.instantiate()
	get_tree().current_scene.add_child(explosion)
	explosion.global_position = global_position
	explosion.affect_enemy(true)
	explosion.set_damage(_damage)
	explosion.explode()
	queue_free()
func _on_lifetime_expired()->void:
	_on_hit(null)
