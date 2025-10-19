class_name SpawnState extends State
@export var idle_state: State
func enter() -> void:
	super()
func process_physics(delta: float) -> Array:
	var _output : Array
	_set_single_state_transition(_output,  idle_state)
	return _output
func get_state_name()->String:
	return "Spawn"
