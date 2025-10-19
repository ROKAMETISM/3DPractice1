class_name WalkState
extends State
@export var stand_state: State
@export var sprint_state: State
func enter() -> void:
	super()
func process_input(event: InputEvent) -> Array:
	var _output : Array
	if get_sprint():
		_output.append(Transition.new(self, Transition.Type.Exit))
		_output.append(Transition.new(sprint_state, Transition.Type.Enter))
	return _output
func process_physics(delta: float) -> Array:
	var _output : Array
	parent.velocity.x = move_data.walk_speed * get_move().x
	parent.velocity.z = move_data.walk_speed * get_move().y
	if not parent.is_on_floor():
		parent.velocity.x = lerp(parent.velocity.x, get_move().x * move_data.walk_speed, delta * move_data.air_control)
		parent.velocity.z = lerp(parent.velocity.z, get_move().y * move_data.walk_speed, delta * move_data.air_control)
	else:
		parent.velocity.x = get_move().x * move_data.walk_speed
		parent.velocity.z = get_move().y * move_data.walk_speed
	parent.move_and_slide()
	if !get_move():
		_output.append(Transition.new(self, Transition.Type.Exit))
		_output.append(Transition.new(stand_state, Transition.Type.Enter))
		return _output
	if get_sprint():
		_output.append(Transition.new(self, Transition.Type.Exit))
		_output.append(Transition.new(sprint_state, Transition.Type.Enter))
	return _output
func get_state_name()->String:
	return "Walk"
