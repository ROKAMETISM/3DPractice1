class_name FlyingState
extends State
@export var fall_state: State
@export var jump_state: State
func enter() -> void:
	super()
	parent.velocity = Vector3.ZERO
func process_physics(delta: float) -> Array:
	var _output : Array
	if Engine.get_physics_frames()%60==0:
		parent.velocity = Vector3(randf_range(-5, 5), randf_range(0, 5), randf_range(-5, 5))
	parent.move_and_slide()
	return _output
func get_state_name()->String:
	return "Flying"
