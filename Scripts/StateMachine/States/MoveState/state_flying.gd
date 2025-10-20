class_name FlyingState
extends State
@export var fall_state: State
@export var jump_state: State
func enter() -> void:
	super()
	parent.velocity = Vector3.ZERO
func process_physics(delta: float) -> Array:
	var _output : Array
	parent.velocity = move_controller.flying_move_input() * move_data.walk_speed
	parent.move_and_slide()
	return _output
func get_state_name()->String:
	return "Flying"
