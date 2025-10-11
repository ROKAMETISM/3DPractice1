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
	debugtext.text += "PlayerGlobalPosition:"+str(player.global_position)
	debugtext.text += "\nPlayerSpeed:"+str(player.velocity.length())
	
