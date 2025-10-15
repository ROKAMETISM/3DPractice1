class_name FallState
extends State
@export var jump_state: State
@export var grounded_state: State
@export var death_state : State
func enter() -> void:
	super()
func process_physics(delta: float) -> Array:
	var _output : Array
	if parent.global_position.y < move_data.fall_death_threshold:
		_output.append(Transition.new(self, Transition.Type.Exit))
		_output.append(Transition.new(death_state, Transition.Type.Enter))
		return _output
	_apply_gravity(delta)
	parent.move_and_slide()
	if parent.is_on_floor():
		_output.append(Transition.new(self, Transition.Type.Exit))
		_output.append(Transition.new(grounded_state, Transition.Type.Enter))
	return _output
func get_state_name()->String:
	return "Fall"
