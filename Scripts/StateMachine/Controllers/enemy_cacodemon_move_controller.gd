class_name EnemyCacodemonMoveController extends MoveController
var target : CharacterBody3D = null
var move_direction := Vector3.ZERO
var last_ground_location := Vector2.ZERO
var want_sprint := false
var want_jump := false
func _physics_process(_delta: float) -> void:
	if not parent:
		return
func flying_move_input() -> Vector3:
	if not parent:
		return Vector3.ZERO
	return move_direction
