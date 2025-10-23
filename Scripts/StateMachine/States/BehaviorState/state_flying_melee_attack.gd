class_name FlyingMeleeAttackState extends State
func enter() -> void:
	super()
	move_controller.target = null
	move_controller.want_jump = false
	move_controller.want_sprint = false
	move_controller.move_direction = Vector3.ZERO
func process_physics(delta: float) -> Array:
	var _output : Array
	return _output
func get_state_name()->String:
	return "FlyingMeleeAttack"
func Vec2toVec3flat(vec2 : Vector2)->Vector3:
	return Vector3(vec2.x, 0, vec2.y)
