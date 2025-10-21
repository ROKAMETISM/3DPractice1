class_name PlayerMoveController
extends MoveController
@onready var fsm : FSM = %FSM
func move_input() -> Vector2:
	var input_dir :Vector2 = Input.get_vector("move_left", "move_right", "move_forward", "move_backward")
	var direction : Vector3 = parent.headpivot.transform.basis * Vector3(input_dir.x, 0, input_dir.y)
	direction = direction.normalized()
	return Vector2(direction.x, direction.z)
func sprint_input() -> bool:
	return Input.is_action_pressed("sprint")
func jump_input() -> bool:
	return Input.is_action_just_pressed('jump')
func _ready() -> void:
	fsm.state_updated.connect(_on_fsm_state_updated)
func _on_fsm_state_updated(new_states : Array[State]):
	for _state in new_states:
		if _state is GroundedState:
			parent.can_jump_midair = true
		
