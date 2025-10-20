class_name IDLEState extends State
@export var chase_state : State
@export var player_detector : Area3D
func enter() -> void:
	super()
	move_controller.target = null
	move_controller.want_jump = false
	move_controller.want_sprint = false
	move_controller.move_direction = Vector2.ZERO
func process_physics(delta: float) -> Array:
	var _output : Array
	if player_detector.get_overlapping_areas().is_empty():
		return _output
	_set_single_state_transition(_output, chase_state)
	move_controller.target = player_detector.get_overlapping_areas().get(0).parent
	move_controller.want_jump = false
	return _output
func get_state_name()->String:
	return "IDLE"
