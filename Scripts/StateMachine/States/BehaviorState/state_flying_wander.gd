class_name FlyingWanderState extends State
@export var flight_height : float = 4.0
@export var flight_height_margin : float = 1.0
@export var ground_detector : RayCast3D
@export var wander_time : float = 3.0
@export var vision_area : Area3D
@export var chase_state : FlyingChaseState
var _wander_timer := 0.0
var _wander_direction_2d := Vector2.ZERO
var _wander_vertical := 0.0
func enter() -> void:
	super()
	move_controller.target = null
	move_controller.want_jump = false
	move_controller.want_sprint = false
	move_controller.move_direction = Vector3.ZERO
	ground_detector.target_position = Vector3(0, -flight_height,0)
func process_physics(delta: float) -> Array:
	var _output : Array
	if !ground_detector.is_colliding():
		move_controller.move_direction = (Vec2toVec3flat(_wander_direction_2d)+Vector3.DOWN).normalized()
	else:
		move_controller.last_ground_location = Vec3toVec2flat(parent.global_position)
		if _get_height() < flight_height - flight_height_margin:
			move_controller.move_direction = (Vec2toVec3flat(_wander_direction_2d)+Vector3.UP).normalized()
		else:
			move_controller.move_direction = (Vec2toVec3flat(_wander_direction_2d)+Vector3(0,_wander_vertical,0)).normalized()
	parent.look_at(parent.global_position + move_controller.move_direction)
	_wander_timer -= delta
	if _wander_timer < 0.0:
		_wander_timer += wander_time
		new_random_wander()
	if vision_area.get_overlapping_areas().is_empty():
		return _output
	_set_single_state_transition(_output, chase_state)
	move_controller.target = vision_area.get_overlapping_areas().get(0).parent
	return _output
func get_state_name()->String:
	return "FlyingWander"
func _get_height()->float:
	if not ground_detector.is_colliding():
		return -1.0
	return (ground_detector.get_collision_point()-parent.global_position).length()
func new_random_wander()->void:
	_wander_direction_2d = Vector2.ONE.rotated(randf_range(0.0, 2*PI))
	_wander_vertical = randf_range(-1.0, 1.0)
func Vec2toVec3flat(vec2 : Vector2)->Vector3:
	return Vector3(vec2.x, 0, vec2.y)
func Vec3toVec2flat(vec3 : Vector3)->Vector2:
	return Vector2(vec3.x, vec3.z)
