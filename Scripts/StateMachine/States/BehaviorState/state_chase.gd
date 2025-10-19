class_name ChaseState extends State
@export var chase_max_distance := 24.0
@export var attack_interval := 2.0
@export var idle_state : State
@export var try_attack_state : State
@export var melee_attack_state : State
@export var melee_range : Area3D
var attack_timer := attack_interval
func enter() -> void:
	super()
	attack_timer = attack_interval
	move_controller.want_sprint = true
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
	attack_timer -= delta
	if attack_timer < 0.0:
		_set_single_state_transition(_output, try_attack_state)
		return _output
	if not melee_range.get_overlapping_areas().is_empty():
		_set_single_state_transition(_output, melee_attack_state)
	return _output
func get_state_name()->String:
	return "Chase"
