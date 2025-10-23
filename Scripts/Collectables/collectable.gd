class_name Collectable extends Area3D
##gets called when the player collects it.
@export var pickup_name := "Collectable"
@onready var ray := $RayCast3D
var _on_floor := true
func collect(source:CharacterBody3D)->void:
	print("Picked up %s"%pickup_name)
	_on_collect(source)
	queue_free()
func _on_collect(_source:CharacterBody3D)->void:
	pass
func _physics_process(delta: float) -> void:
	_on_floor = ray.is_colliding()
	if not _on_floor:
		position.y -= delta * 2.0
