extends MeshInstance3D
const SPEED := 3.5
const GRAVITY := 13.0
const RANDOMNESS := 1.5
var lifetime := 0.5
var velocity := Vector3.ZERO
var rand_velocity := Vector3.ZERO
const shothit = preload("uid://cx03ji6146wt8")
func _physics_process(delta: float) -> void:
	lifetime -= delta
	if lifetime < 0.0:
		queue_free()
	position += velocity * delta
	velocity.y -= GRAVITY * delta
func set_direction(direction : Vector3) -> void:
	velocity = direction * SPEED
	rand_velocity = Vector3(RANDOMNESS, 0.0, 0.0)
	rand_velocity = rand_velocity.rotated(Vector3.FORWARD, randf_range(0.0, 2*PI))
	rand_velocity = rand_velocity.rotated(Vector3.UP, randf_range(0.0, 2*PI))
	velocity += rand_velocity
