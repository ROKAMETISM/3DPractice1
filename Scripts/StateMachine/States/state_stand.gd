class_name StandState
extends State
@export var move_state: State
@export var sprint_state: State
func enter() -> void:
	super()
	parent.velocity.x = 0
func process_input(event: InputEvent) -> Array:
	var _output : Array
	if get_move():
		_output.append(Transition.new(self, Transition.Type.Exit))
		_output.append(Transition.new(move_state, Transition.Type.Enter))
	return _output
func process_physics(delta: float) -> Array:
	var _output : Array
	if get_move():
		_output.append(Transition.new(self, Transition.Type.Exit))
		_output.append(Transition.new(move_state, Transition.Type.Enter))
	parent.move_and_slide()
	return _output
func get_state_name()->String:
	return "Stand"
