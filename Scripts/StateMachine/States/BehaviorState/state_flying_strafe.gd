class_name FlyingStrafeState extends State
@export var strafe_time := 3.0
@export var strafe_direction := -1
@export var strafe_min_distance := 5.0
@export var strafe_max_distnace := 8.0
@export var strafe_height := 3.0
@export var strafe_height_margin := 1.0
@export var wander_state : State
@export var chase_state : State
var move_direction := Vector3.ZERO
var _strafe_timer := strafe_time
func enter() -> void:
	super()
	_strafe_timer = strafe_time
func process_physics(delta: float) -> Array:
	var _output : Array
	if not move_controller.target:
		_set_single_state_transition(_output, wander_state)
		return _output
	_strafe_timer -= delta
	if _strafe_timer < 0.0:
		_set_single_state_transition(_output, chase_state)
		return _output
	if _get_target_distance() < strafe_min_distance:
		_set_single_state_transition(_output, chase_state)
	if _get_target_distance() > strafe_max_distnace:
		_set_single_state_transition(_output, chase_state)
		return _output
	parent.look_at(move_controller.target.global_position)
	move_direction = -parent.transform.basis.x
	if parent.global_position.y - move_controller.target.global_position.y < strafe_height - strafe_height_margin:
		move_direction += Vector3.UP
	elif parent.global_position.y - move_controller.target.global_position.y > strafe_height + strafe_height_margin:
		move_direction += Vector3.DOWN
	move_controller.move_direction = move_direction.normalized()
	return _output
func get_state_name()->String:
	return "FlyingStrafe"
func _get_target_distance()->float:
	if not move_controller.target:
		return 0.0
	return (move_controller.target.global_position - parent.global_position).length()
