extends CharacterBody3D
const SPEED := 5.0
const JUMP_VELOCITY := 4.5
const MAX_HP := 10.0
var current_hp := MAX_HP
func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
	move_and_slide()
