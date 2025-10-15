class_name State
extends Node
# Hold a reference to the parent so that it can be controlled by the state
@export var state_log := false
var parent:CharacterBody3D
var fsm:FSM
var move_data:MoveData
var move_controller:MoveController
func enter() -> void:
	if state_log:
		print("++entered : " + get_state_name())
	pass
func exit() -> void:
	if state_log:
		print("--exiting : " + get_state_name())
	pass
func process_input(event: InputEvent) -> Array:
	return []
func process_frame(delta: float) -> Array:
	return []
func process_physics(delta: float) -> Array:
	return []
func fsm_get_current_states()->Array[State]:
	return fsm.current_states
func is_state_active(state:State)->bool:
	return fsm.current_states.has(state)
func get_move() -> Vector2:
	return move_controller.move_input()
func get_sprint() -> bool:
	return move_controller.sprint_input()
func get_jump() -> bool:
	return move_controller.jump_input()
func get_state_name()->String:
	return "BaseStateName"
func _apply_gravity(delta:float)->void:
	if parent.velocity.y<0:
		parent.velocity.y -= move_data.jump_gravity * delta
	else:
		parent.velocity.y -= move_data.fall_gravity * delta
