extends Projectile
const EXPLOSION := preload("uid://bp3mahismsqco")
const GRAVITY := 6.0
@export var attached_detonation_time := 0.4
@onready var sprite := $Sprite3D
var attached = false
func _ready() -> void:
	super()
	sprite.animation = "default"
func _physics_process(delta: float) -> void:
	super(delta)
	if attached:
		return
	_velocity.y -= GRAVITY*delta
func _on_hit(collider:Node3D)->void:
	attached = true
	sprite.animation = "attached"
	_lifetime = attached_detonation_time
	_velocity = Vector3.ZERO
	var original_position = global_position
	get_parent().remove_child(self)
	collider.add_child(self)
	global_position = original_position
func _on_lifetime_expired()->void:
	grenade_explode()
func grenade_explode() -> void:
	var explosion : Area3D = EXPLOSION.instantiate()
	get_tree().current_scene.add_child(explosion)
	explosion.global_position = global_position
	explosion.affect_enemy(true)
	explosion.set_damage(_damage)
	explosion.explode()
	queue_free()
