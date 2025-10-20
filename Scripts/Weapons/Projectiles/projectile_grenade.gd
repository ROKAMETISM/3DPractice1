extends Area3D
const EXPLOSION := preload("uid://bp3mahismsqco")
const GRAVITY := 6.0
@export var attached_detonation_time := 0.4
@onready var sprite := $Sprite3D
var velocity := Vector3.ZERO
var _damage := 8.0
var _lifetime := 1.0
var attached = false
func _ready() -> void:
	sprite.animation = "default"
func _physics_process(delta: float) -> void:
	_lifetime -= delta
	if _lifetime <= 0.0:
		grenade_explode()
	if attached:
		return
	velocity.y -= GRAVITY*delta
	position += velocity*delta
func _on_area_entered(area: Node3D) -> void:
	set_attached()
	var original_position = global_position
	get_parent().remove_child(self)
	area.add_child(self)
	global_position = original_position
func grenade_explode() -> void:
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
func set_lifetime(life : float)->void:
	_lifetime = life
func _on_body_entered(body: Node3D) -> void:
	set_attached()
	var original_position = global_position
	get_parent().remove_child(self)
	body.add_child(self)
	global_position = original_position
func set_attached()->void:
	attached = true
	sprite.animation = "attached"
	set_lifetime(attached_detonation_time)
