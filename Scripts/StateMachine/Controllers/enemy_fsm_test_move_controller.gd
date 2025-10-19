class_name EnemyFSMTestMoveController extends MoveController
var target : CharacterBody3D = null
var move_direction := Vector2.ZERO
var want_sprint := false
var want_jump := false
func _physics_process(delta: float) -> void:
	if not parent:
		return
func move_input() -> Vector2:
	if not parent:
		return Vector2.ZERO
	if not target:
		return Vector2.ZERO
	return move_direction
func sprint_input() -> bool:
	return want_sprint
func jump_input() -> bool:
	return want_jump
func _is_destination_reached(destination:Vector3, threshold_distance:float) -> bool:
	if not parent:
		return false
	var displacement := parent.global_position - destination
	if Vector2(displacement.x, displacement.z).length() < threshold_distance:
		return true
	return false
