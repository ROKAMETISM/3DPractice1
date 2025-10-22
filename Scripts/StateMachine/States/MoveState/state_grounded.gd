class_name GroundedState
extends State
@export var fall_state: State
@export var jump_state: State
func enter() -> void:
	super()
	parent.velocity.y = 0
func process_input(_event: InputEvent) -> Array:
	var _output : Array
	if get_jump():
		_set_single_state_transition(_output,  jump_state)
	return _output
func process_physics(_delta: float) -> Array:
	var _output : Array
	parent.velocity.y = 0.0
	parent.move_and_slide()
	if !parent.is_on_floor():
		_set_single_state_transition(_output,  fall_state)
		return _output
	if get_jump():
		_set_single_state_transition(_output,  jump_state)
		return _output
	return _output
func get_state_name()->String:
	return "Grounded"
