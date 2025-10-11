extends Node3D
@onready var player := %Player
@onready var debugtext := %DebugText
func _physics_process(delta: float) -> void:
	if Input.is_action_just_pressed("quit"):
		get_tree().quit()
		return
	if Input.is_action_just_pressed("restart_game"):
		get_tree().reload_current_scene()
		return
	debugtext.text = ""
	debugtext.text += "PlayerGlobalPosition:["
	debugtext.text += "%.2f, " %player.global_position.x
	debugtext.text += "%.2f, " %player.global_position.y
	debugtext.text += "%.2f]" %player.global_position.z
	debugtext.text += "\nPlayerSpeed:%.2f"%player.velocity.length()
	debugtext.text += "\nPlayerYAcceleration:%.2f"%player.acceleration_y
	debugtext.text += "\nPlayerJumpInitAccel:%.2f"%player.jump_initial_acceleration
	
