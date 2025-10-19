class_name SprintState
extends State
@export var stand_state: State
@export var walk_state: State
func enter() -> void:
	super()
func process_input(event: InputEvent) -> Array:
	var _output : Array
	if !get_sprint():
		_set_single_state_transition(_output,  walk_state)
	return _output
func process_physics(delta: float) -> Array:
	var _output : Array
	parent.velocity.x = move_data.sprint_speed * get_move().x
	parent.velocity.z = move_data.sprint_speed * get_move().y
	parent.move_and_slide()
	if !get_move():
		_set_single_state_transition(_output,  stand_state)
		return _output
	if !get_sprint():
		_set_single_state_transition(_output,  walk_state)
	return _output
func get_state_name()->String:
	return "Sprint"
