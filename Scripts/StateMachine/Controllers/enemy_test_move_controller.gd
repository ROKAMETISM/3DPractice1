class_name EnemyTestMoveController
extends MoveController
func move_input() -> Vector2:
	return Vector2.ZERO
func sprint_input() -> bool:
	return Input.is_action_pressed("sprint")
func jump_input() -> bool:
	return Input.is_action_just_pressed('jump')
