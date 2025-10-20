class_name RangedAttackState extends State
@export var idle_state : State
@export var chase_state : State
@export var attack_duration := 0.7
var attack_timer := attack_duration
func enter() -> void:
	super()
	attack_timer = attack_duration
	move_controller.move_direction = Vector2.ZERO
	parent.weapon_fireball.fire_main_pressed()
func process_physics(delta: float) -> Array:
	var _output : Array
	attack_timer -= delta
	if attack_timer < 0.0:
		_set_single_state_transition(_output, chase_state)
		return _output
	return _output
func get_state_name()->String:
	return "RangedAttack"
