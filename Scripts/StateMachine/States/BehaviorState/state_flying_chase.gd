class_name FlyingChaseState extends State
@export var chase_max_distance := 24.0
@export var chase_height_margin := 2.5
@export var wander_state : State
@export var strafe_state : State
@export var melee_attack_state : State
@export var melee_distance : float
func enter() -> void:
	super()
func process_physics(delta: float) -> Array:
	var _output : Array
	if not move_controller.target:
		_set_single_state_transition(_output, wander_state)
		return _output
	parent.look_at(move_controller.target.global_position + Vector3(0,chase_height_margin,0))
	move_controller.move_direction = -parent.transform.basis.z
	if (move_controller.target.global_position - parent.global_position).length() > chase_max_distance:
		_set_single_state_transition(_output, wander_state)
		return _output
	return _output
func get_state_name()->String:
	return "Chase"
