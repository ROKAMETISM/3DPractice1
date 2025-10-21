class_name PlayerJumpState
extends JumpState
@export var jump_state : PlayerJumpState
var _jump_min_interval := 0.1
func enter() -> void:
	super()
	_jump_min_interval = 0.1
func process_input(event: InputEvent) -> Array:
	var _output : Array
	if _jump_min_interval > 0.0:
		return _output
	if get_jump() and parent.can_jump_midair:
		parent.can_jump_midair = false
		parent.can_jump_midair_updated.emit(false)
		_set_single_state_transition(_output,  jump_state)
	return _output
func process_physics(delta: float) -> Array:
	if _jump_min_interval > 0.0:
		_jump_min_interval -= delta
	var _output : Array
	_apply_gravity(delta)
	parent.move_and_slide()
	if parent.velocity.y <= 0.0:
		_set_single_state_transition(_output,  fall_state)
		return _output
	if parent.is_on_floor():
		_set_single_state_transition(_output,  grounded_state)
		return _output
	return _output
func get_state_name()->String:
	return "PlayerJump"
