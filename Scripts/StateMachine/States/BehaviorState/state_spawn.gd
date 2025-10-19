class_name SpawnState extends State
@export var walk_state: State
@export var sprint_state: State
func enter() -> void:
	super()
func process_physics(delta: float) -> Array:
	var _output : Array
	parent.look_at(parent.global_position+Vector3(randf_range(-1, 1), 0, randf_range(-1, 1)))
	return _output
func get_state_name()->String:
	return "Spawn"
