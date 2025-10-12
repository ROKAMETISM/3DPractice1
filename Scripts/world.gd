extends Node3D
@onready var player := %Player
@onready var debugtext := %DebugText
func _ready() -> void:
	player.player_position_updated.connect(debugtext.set_player_postion)
	player.player_velocity_updated.connect(debugtext.set_player_velocity)
	player.player_y_acceleration_updated.connect(debugtext.set_player_y_acceleration)
func _physics_process(delta: float) -> void:
	if Input.is_action_just_pressed("quit"):
		get_tree().quit()
		return
	if Input.is_action_just_pressed("restart_game"):
		get_tree().reload_current_scene()
		return
	
