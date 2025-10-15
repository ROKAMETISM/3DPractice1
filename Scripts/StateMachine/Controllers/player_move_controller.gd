class_name PlayerMoveController
extends MoveController
func move_input() -> Vector2:
	var input_dir = Input.get_vector("move_left", "move_right", "move_forward", "move_backward")
	var direction = (parent.headpivot.transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	return Vector2(direction.x, direction.z)
func sprint_input() -> bool:
	return Input.is_action_pressed("sprint")
func jump_input() -> bool:
	return Input.is_action_just_pressed('jump')
