class_name JumpState
extends State
@export var fall_state: State
@export var grounded_state: State
func enter() -> void:
	super()
	parent.velocity.y = move_data.jump_velocity
func process_physics(delta: float) -> Array:
	var _output : Array
	_apply_gravity(delta)
	parent.move_and_slide()
	if parent.velocity.y > 0:
		_output.append(Transition.new(self, Transition.Type.Exit))
		_output.append(Transition.new(fall_state, Transition.Type.Enter))
	return _output
func get_state_name()->String:
	return "Jump"
