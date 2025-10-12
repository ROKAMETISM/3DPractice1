extends Node3D
@onready var player := %Player
@onready var hud := %HUD
func _ready() -> void:
	player.player_position_updated.connect(hud.set_player_postion)
	player.player_velocity_updated.connect(hud.set_player_velocity)
	player.player_y_acceleration_updated.connect(hud.set_player_y_acceleration)
	player.weapon_manager.weapon_switched.connect(hud.set_current_weapon)
	player.player_fov_updated.connect(hud.crosshair.set_fov)
	print("debug signal connected")
	player.weapon_manager.switch_weapon(0)
func _physics_process(delta: float) -> void:
	if Input.is_action_just_pressed("quit"):
		get_tree().quit()
		return
	if Input.is_action_just_pressed("restart_game"):
		get_tree().reload_current_scene()
		return
	
