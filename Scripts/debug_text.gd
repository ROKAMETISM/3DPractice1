extends Label
@onready var hud := get_parent()
func update_text() -> void:
	text = ""
	text += "\nFPS:%.2f"%Engine.get_frames_per_second()
	text += "\nPlayerGlobalPosition:["
	text += "%.2f, " %hud.player_position.x
	text += "%.2f, " %hud.player_position.y
	text += "%.2f]" %hud.player_position.z
	text += "\nPlayerSpeed:%.2f"%hud.player_velocity.length()
	text += "\nPlayerHSpeed:%.2f"%Vector2(hud.player_velocity.x, hud.player_velocity.z).length()
	text += "\nPlayerVSpeed:%.2f"%absf(hud.player_velocity.y)
	text += "\nPlayerYAcceleration:%.2f"%hud.player_y_acceleration
	text += "\nCurrentWeapon:"
	if hud.current_weapon:
		text += hud.current_weapon.WEAPON_NAME
	else:
		text += "NULL"
