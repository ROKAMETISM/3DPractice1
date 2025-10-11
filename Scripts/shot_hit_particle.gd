extends MeshInstance3D
const SPEED := 2.0
const GRAVITY := 9.8
var lifetime := 0.5
var velocity := Vector3.ZERO
func _physics_process(delta: float) -> void:
	lifetime -= delta
	if lifetime < 0.0:
		queue_free()
	position += velocity * delta
	velocity.y -= GRAVITY * delta
func set_direction(direction : Vector3) -> void:
	velocity = direction * SPEED
