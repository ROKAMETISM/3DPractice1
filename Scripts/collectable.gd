class_name Collectable extends Area3D
##gets called when the player collects it.
@export var pickup_name := "Collectable"
func collect(source:CharacterBody3D)->void:
	print("Picked up %s"%pickup_name)
	_on_collect(source)
	queue_free()
func _on_collect(source:CharacterBody3D)->void:
	pass
