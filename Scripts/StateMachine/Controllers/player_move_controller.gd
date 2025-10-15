class_name PlayerMoveController
extends MoveController
func move_input() -> Vector2:
	var input_dir = Input.get_vector("move_left", "move_right", "move_forward", "move_backward")
	var direction = (headpivot.transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if not is_on_floor():
		velocity.x = lerp(velocity.x, direction.x * speed, delta * AIRCONTROL)
		velocity.z = lerp(velocity.z, direction.z * speed, delta * AIRCONTROL)
	else:
		if direction : 
			velocity.x = direction.x * speed
			velocity.z = direction.z * speed
		else:
			velocity.x = 0.0
			velocity.z = 0.0
	return Input.get_vector("move_left", "move_right", "move_forward", "move_backward")
func sprint_input() -> bool:
	return Input.is_action_pressed("sprint")
func jump_input() -> bool:
	return Input.is_action_just_pressed('jump')
