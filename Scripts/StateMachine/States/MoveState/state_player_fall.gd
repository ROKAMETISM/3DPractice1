class_name PlayerFallState
extends FallState
func enter() -> void:
	super()
func process_input(event: InputEvent) -> Array:
	var _output : Array
	if get_jump() and parent.can_jump_midair:
		parent.can_jump_midair = false
		parent.can_jump_midair_updated.emit(false)
		_set_single_state_transition(_output,  jump_state)
	return _output
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
	return "PlayerFall"
