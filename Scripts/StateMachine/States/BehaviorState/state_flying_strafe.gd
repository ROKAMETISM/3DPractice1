class_name FlyingStrafeState extends State
@export var strafe_time := 3.0
@export var strafe_direction := -1
@export var strafe_min_distance := 5.0
@export var strafe_max_distnace := 8.0
@export var strafe_height := 1.5
@export var wander_state : State
@export var chase_state : State
var move_direction := Vector3.ZERO
func enter() -> void:
	super()
func process_physics(delta: float) -> Array:
	var _output : Array
	if not move_controller.target:
		_set_single_state_transition(_output, wander_state)
		return _output
	parent.look_at(move_controller.target.global_position)
	move_direction = -parent.transform.basis.x
	if parent.global_position.y - move_controller.target.global_position.y < strafe_height:
		move_direction += Vector3.UP
	else:
		move_direction += Vector3.DOWN
	if _get_target_distance() < strafe_min_distance:
		move_direction +=  2 * parent.transform.basis.z
	if _get_target_distance() > strafe_max_distnace:
		move_direction +=  -2 * parent.transform.basis.z
	move_controller.move_direction = move_direction.normalized()
	return _output
func get_state_name()->String:
	return "FlyingStrafe"
func _get_target_distance()->float:
	if not move_controller.target:
		return 0.0
	return (move_controller.target.global_position - parent.global_position).length()
