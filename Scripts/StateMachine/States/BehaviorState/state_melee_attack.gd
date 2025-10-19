class_name MeleeAttackState extends State
@export var idle_state : State
@export var chase_state : State
@export var attack_state_expiration_time := 3.0
var melee_timer := attack_state_expiration_time
func enter() -> void:
	super()
	melee_timer = attack_state_expiration_time
	move_controller.move_direction = Vector2.ZERO
func process_physics(delta: float) -> Array:
	var _output : Array
	melee_timer -= delta
	if melee_timer < 0.0:
		_set_single_state_transition(_output, idle_state)
		return _output
	return _output
func get_state_name()->String:
	return "MeleeAttack"
