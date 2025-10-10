extends Node3D
@onready var player := %Player
@onready var debugtext := %DebugText
func _physics_process(delta: float) -> void:
	if Input.is_action_just_pressed("quit"):
		get_tree().quit()
	if Input.is_action_just_pressed("restart_game"):
		get_tree().reload_current_scene()
