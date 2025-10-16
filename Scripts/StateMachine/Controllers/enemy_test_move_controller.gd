class_name EnemyTestMoveController
extends MoveController
const WANDER_RANGE := 12.0
const JUMP_RATE := 3.5
const JUMP_RATE_SPREAD := 1.0
const SPRINT_RATE := 2.0
const PAUSE_TIME := 3.0
var jump_timer := 2.0
var pause_timer := 0.0
var want_jump := false
var sprinting := false
var sprint_timer := 0.0
var home_position := Vector3.ZERO
var destination := home_position
func _physics_process(delta: float) -> void:
	if not parent:
		return
	if _is_destination_reached():
		destination = home_position + Vector3(WANDER_RANGE, 0, 0).rotated(Vector3.UP, randf_range(0, 2*PI))
		parent.look_at(destination)
		pause_timer = PAUSE_TIME
	jump_timer = max(jump_timer - delta, 0.0)
	sprint_timer = max(sprint_timer - delta, 0.0)
	pause_timer = max(pause_timer - delta, 0.0)
	want_jump = false
	if jump_timer > JUMP_RATE - 0.5:
		want_jump = true
	if jump_timer == 0.0:
		jump_timer = JUMP_RATE + randf_range(-JUMP_RATE_SPREAD, JUMP_RATE_SPREAD)
	if sprint_timer == 0.0:
		sprint_timer = SPRINT_RATE
		sprinting = not sprinting
func move_input() -> Vector2:
	if not parent:
		return Vector2.ZERO
	if pause_timer > 0.0:
		return Vector2.ZERO
	var direction := -parent.transform.basis.z
	return Vector2(direction.x, direction.z)
func sprint_input() -> bool:
	return sprinting
func jump_input() -> bool:
	return want_jump
func _is_destination_reached() -> bool:
	if not parent:
		return false
	var displacement := parent.global_position - destination
	if Vector2(displacement.x, displacement.z).length() < 3.0:
		return true
	return false
func set_home_position(global_position : Vector3) -> void:
	home_position = global_position
	destination = home_position
