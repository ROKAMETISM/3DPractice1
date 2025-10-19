class_name TryAttackState extends State
@export var chase_state : State
@export var melee_attack_state : State
@export var ranged_attack_state : State
@export var melee_range : Area3D
func enter() -> void:
	super()
func process_physics(delta: float) -> Array:
	var _output : Array
	if melee_range.get_overlapping_areas().is_empty():
		_set_single_state_transition(_output, ranged_attack_state)
	else:
		_set_single_state_transition(_output, melee_attack_state)
	return _output
func get_state_name()->String:
	return "TryAttack"
