class_name SprintState
extends State
@export var stand_state: State
@export var walk_state: State
func enter() -> void:
	super()
func process_input(event: InputEvent) -> Array:
	var _output : Array
	if !get_sprint():
		_output.append(Transition.new(self, Transition.Type.Exit))
		_output.append(Transition.new(walk_state, Transition.Type.Enter))
	return _output
func process_physics(delta: float) -> Array:
	var _output : Array
	parent.velocity.x = move_data.sprint_speed * get_move().x
	parent.velocity.z = move_data.sprint_speed * get_move().y
	parent.move_and_slide()
	if !get_move():
		_output.append(Transition.new(self, Transition.Type.Exit))
		_output.append(Transition.new(stand_state, Transition.Type.Enter))
		return _output
	if !get_sprint():
		_output.append(Transition.new(self, Transition.Type.Exit))
		_output.append(Transition.new(walk_state, Transition.Type.Enter))
	return _output
func get_state_name()->String:
	return "Sprint"
