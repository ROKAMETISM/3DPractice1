class_name StandState
extends State
@export var walk_state: State
@export var sprint_state: State
@export var friction := 13.0
func enter() -> void:
	super()
func process_input(event: InputEvent) -> Array:
	var _output : Array
	if get_move():
		_set_single_state_transition(_output,  walk_state)
	return _output
func process_physics(delta: float) -> Array:
	var _output : Array
	if get_move():
		_set_single_state_transition(_output,  walk_state)
	if parent.is_on_floor():
		if parent.velocity.length() < 0.1:
			parent.velocity = Vector3.ZERO
		else:
			parent.velocity = lerp(parent.velocity, Vector3.ZERO, delta * friction)
	parent.move_and_slide()
	return _output
func get_state_name()->String:
	return "Stand"
