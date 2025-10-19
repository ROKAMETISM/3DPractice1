##GDScript for HUD < Control.
extends Control
##reference to the corresponding node.
@onready var debug_text := %DebugText
##reference to the corresponding node.
@onready var crosshair := %Crosshair
##reference to the corresponding node.
@onready var hp_bar := %HPBar
##reference to the corresponding node.
@onready var armor_bar := %ArmorBar
##reference to the corresponding node.
@onready var ammo_icon := %AmmoIcon
##reference to the corresponding node.
@onready var ammo_text := %AmmoText
##triggers on player position_updated siganl
##updates debug text
func _on_player_position_updated(new_position : Vector3) -> void:
	debug_text.player_position = new_position
	debug_text.update_text() 
##triggers on player velocity_updated siganl
##updates debug text
func _on_player_velocity_updated(new_velocity : Vector3) -> void:
	debug_text.player_velocity = new_velocity
	debug_text.update_text() 
##triggers on player y_acceleration_updated siganl
##updates debug text
func _on_player_y_acceleration_updated(new_y_acceleration : float) -> void:
	debug_text.player_y_acceleration = new_y_acceleration
	debug_text.update_text() 
##triggers on player fov_updated siganl
##updates crosshair
func _on_player_fov_updated(new_fov:float)->void:
	crosshair.set_hov(new_fov)
func _on_weapon_switched(new_weapon : Node3D) -> void:
	debug_text.current_weapon = new_weapon
	ammo_text.current_weapon = new_weapon
	debug_text.update_text()
	crosshair.set_weapon_spread(new_weapon.get_spread_angle_rad())
	ammo_icon.set_icon(new_weapon.ammo_type)
	ammo_text.update()
func _on_ammo_updated(type:Weapon.AmmoType, value:int)->void:
	debug_text.current_ammo[type]= value
	debug_text.update_text()
	ammo_text.current_ammo[type]= value
	ammo_text.update()
func _on_player_fsm_state_updated(new_states : Array[State]):
	debug_text.player_fsm_states = new_states
func _on_player_hp_updated(player_hp:HPComponent)->void:
	armor_bar.player_hp_component = player_hp
	hp_bar.player_hp_component = player_hp
	armor_bar.update()
	hp_bar.update()
func set_max_ammo(type:Weapon.AmmoType, value:int)->void:
	debug_text.max_ammo[type]= value
	ammo_text.max_ammo[type]=value
	debug_text.update_text()
	ammo_text.update()
