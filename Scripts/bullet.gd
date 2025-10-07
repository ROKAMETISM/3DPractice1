extends Area3D

var lifetime := 3.0

func _process(delta: float) -> void:
	lifetime -= delta
	if lifetime < 0.0:
		queue_free()
