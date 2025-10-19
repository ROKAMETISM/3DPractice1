class_name StandState
extends State
@export var walk_state: State
@export var sprint_state: State
func enter() -> void:
	super()
func process_input(event: InputEvent) -> Array:
	var _output : Array
	if get_move():
		_set_single_state_transition(_output,  walk_state)
	return _output
func process_physics(delta: float) -> Array:
	var _output : Array
	if get_move():
		_set_single_state_transition(_output,  walk_state)
	parent.move_and_slide()
	return _output
func get_state_name()->String:
	return "Stand"
