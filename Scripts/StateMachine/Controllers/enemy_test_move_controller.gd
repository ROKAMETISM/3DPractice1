class_name EnemyTestMoveController
extends MoveController
var home_position := Vector3.ZERO
var destination := home_position
const WANDER_RANGE := 16.0
func _physics_process(delta: float) -> void:
	if not parent:
		return
	if _is_destination_reached():
		destination = home_position + Vector3(WANDER_RANGE, 0, 0).rotated(Vector3.UP, randf_range(0, 2*PI))
		parent.look_at(destination)
func move_input() -> Vector2:
	if not parent:
		return Vector2.ZERO
	var direction := -parent.transform.basis.z
	return Vector2(direction.x, direction.z)
func sprint_input() -> bool:
	return false
func jump_input() -> bool:
	return false
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
