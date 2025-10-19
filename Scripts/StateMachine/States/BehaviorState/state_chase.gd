class_name ChaseState extends State
@export var chase_max_distance := 16.0
@export var idle_state : State
func enter() -> void:
	super()
func process_physics(delta: float) -> Array:
	var _output : Array
	if (move_controller.target.global_position - parent.global_position).length() > chase_max_distance:
		_set_single_state_transition(_output, idle_state)
	return _output
func get_state_name()->String:
	return "Chase"
