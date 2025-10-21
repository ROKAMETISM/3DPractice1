class_name FallState
extends State
@export var jump_state: JumpState
@export var grounded_state: GroundedState
@export var death_state : DeathState
func enter() -> void:
	super()
func process_physics(delta: float) -> Array:
	var _output : Array
	if parent.global_position.y < move_data.fall_death_threshold:
		_set_single_state_transition(_output,  death_state)
		return _output
	_apply_gravity(delta)
	parent.move_and_slide()
	if parent.is_on_floor():
		_set_single_state_transition(_output,  grounded_state)
	return _output
func get_state_name()->String:
	return "Fall"
