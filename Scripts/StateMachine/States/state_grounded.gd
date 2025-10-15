class_name GroundedState
extends State
@export var fall_state: State
@export var jump_state: State
func enter() -> void:
	super()
	parent.velocity.y = 0
func process_input(event: InputEvent) -> Array:
	var _output : Array
	if get_jump() and parent.is_on_floor():
		_output.append(Transition.new(self, Transition.Type.Exit))
		_output.append(Transition.new(jump_state, Transition.Type.Enter))
	return _output
func process_physics(delta: float) -> Array:
	var _output : Array
	parent.velocity.y = 0.0
	parent.move_and_slide()
	if get_jump() and parent.is_on_floor():
		_output.append(Transition.new(self, Transition.Type.Exit))
		_output.append(Transition.new(jump_state, Transition.Type.Enter))
		return _output
	if !parent.is_on_floor():
		_output.append(Transition.new(self, Transition.Type.Exit))
		_output.append(Transition.new(fall_state, Transition.Type.Enter))
	return _output
func get_state_name()->String:
	return "Grounded"
