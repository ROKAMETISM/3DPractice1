class_name ChaseState extends State
@export var chase_max_distance := 16.0
@export var idle_state : State
@export var melee_attack_state : State
@export var melee_range : Area3D
func enter() -> void:
	super()
func process_physics(delta: float) -> Array:
	var _output : Array
	if not move_controller.target:
		_set_single_state_transition(_output, idle_state)
		return _output
	parent.look_at(move_controller.target.global_position)
	var direction := -parent.transform.basis.z
	move_controller.move_direction = Vector2(direction.x, direction.z)
	if (move_controller.target.global_position - parent.global_position).length() > chase_max_distance:
		_set_single_state_transition(_output, idle_state)
		return _output
	if not melee_range.get_overlapping_areas().is_empty():
		_set_single_state_transition(_output, melee_attack_state)
	return _output
func get_state_name()->String:
	return "Chase"
