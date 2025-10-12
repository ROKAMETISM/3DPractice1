extends Label
var player_position := Vector3.ZERO
var player_velocity := Vector3.ZERO
var player_y_acceleration := 0.0
var current_weapon : Node3D
func set_player_postion(new_position : Vector3) -> void:
	player_position = new_position
	update_text() 
func set_player_velocity(new_velocity : Vector3) -> void:
	player_velocity = new_velocity
	update_text() 
func set_player_y_acceleration(new_y_acceleration : float) -> void:
	player_y_acceleration = new_y_acceleration
	update_text() 
func set_current_weapon(new_weapon : Node3D) -> void:
	print("set current weapon")
	current_weapon = new_weapon
	update_text()
func update_text() -> void:
	text = ""
	text += "\nFPS:%.2f"%Engine.get_frames_per_second()
	text += "\nPlayerGlobalPosition:["
	text += "%.2f, " %player_position.x
	text += "%.2f, " %player_position.y
	text += "%.2f]" %player_position.z
	text += "\nPlayerSpeed:%.2f"%player_velocity.length()
	text += "\nPlayerHSpeed:%.2f"%Vector2(player_velocity.x, player_velocity.z).length()
	text += "\nPlayerVSpeed:%.2f"%absf(player_velocity.y)
	text += "\nPlayerYAcceleration:%.2f"%player_y_acceleration
	text += "\nCurrentWeapon:"
	if current_weapon:
		text += current_weapon.WEAPON_NAME
	else:
		text += "NULL"
