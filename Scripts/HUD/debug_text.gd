extends Label
var player_position := Vector3.ZERO
var player_velocity := Vector3.ZERO
var player_y_acceleration := 0.0
var current_weapon : Weapon
var current_ammo : Dictionary[Weapon.AmmoType, int]
var max_ammo : Dictionary[Weapon.AmmoType, int]
var player_fsm_states : Array[State]
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
		text += current_weapon.get_weapon_name()
	else:
		text += "NULL"
	text += "\nCurrentStates:"
	for state:State in player_fsm_states:
		text += state.get_state_name() + "/"
	text += "\nWeaponManagerCurrentAmmo:\n"
	for ammo_type in current_ammo:
		text+=Weapon.AmmoType.keys().get(ammo_type)
		text+=":%d\n"%current_ammo.get(ammo_type)
