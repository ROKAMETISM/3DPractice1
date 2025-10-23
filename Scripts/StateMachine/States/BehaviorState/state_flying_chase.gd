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
	parent.look_at(move_controller.target.global_position + Vector3(0,chase_height_margin * sigmoid(_get_target_distance()-1.0),0))
	move_controller.move_direction = -parent.transform.basis.z
	if _get_target_distance() > chase_max_distance:
		_set_single_state_transition(_output, wander_state)
		return _output
	if _get_target_distance() < melee_distance : 
		return _output
	if randi_range(0, 600) < 2:
		_set_single_state_transition(_output, strafe_state)
	return _output
func get_state_name()->String:
	return "FlyingChase"
func _get_target_distance()->float:
	if not move_controller.target:
		return 0.0
	return (move_controller.target.global_position - parent.global_position).length()
func sigmoid(value:float)->float:
	return (2.0 / 1 + exp(-value)) - 1.0
