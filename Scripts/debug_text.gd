extends Label
@onready var hud := %HUD
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
		text += hud.current_weapon.get_weapon_name()
	else:
		text += "NULL"
	text += "\nCurrentStates:"
	for state:State in hud.player_fsm_states:
		text += state.get_state_name() + "/"
	text += "\nWeaponManagerCurrentAmmo:\n"
	for ammo_type in hud.weapon_manager_current_ammo:
		text+=Weapon.AmmoType.keys().get(ammo_type)
		text+=":%d\n"%hud.weapon_manager_current_ammo.get(ammo_type)
