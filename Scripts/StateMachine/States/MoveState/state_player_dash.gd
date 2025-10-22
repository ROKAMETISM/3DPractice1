class_name PlayerDashState extends State
@export var fall_state : PlayerFallState
@export var stand_state : StandState
@export var dash_time := 0.3
@export var dash_speed := 10.0
var _dash_timer := dash_time
func enter() -> void:
	super()
	if move_controller.move_input():
		print("moveinput")
		parent.velocity = _get_Vec3_move_input()*dash_speed
	else:
		print("no moveinput")
		parent.velocity = parent.pointing_vector.normalized()*dash_speed
	parent.velocity.y = 0.0
	_dash_timer = dash_time
	print(parent.velocity)
func process_physics(delta: float) -> Array:
	var _output : Array
	_dash_timer -= delta
	if _dash_timer <= 0.0:
		parent.velocity = parent.velocity.normalized()*move_data.sprint_speed
		_output.append(Transition.new(self, Transition.Type.Exit))
		_output.append(Transition.new(fall_state, Transition.Type.Enter))
		_output.append(Transition.new(stand_state, Transition.Type.Enter))
	parent.move_and_slide()
	return _output
func get_state_name()->String:
	return "PlayerDash"
func _get_Vec3_move_input()->Vector3:
	var direction2d : Vector2 = move_controller.move_input()
	return Vector3(direction2d.x, 0.0, direction2d.y).normalized()
