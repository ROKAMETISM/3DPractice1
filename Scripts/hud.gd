extends Control
var player_position := Vector3.ZERO
var player_velocity := Vector3.ZERO
var player_y_acceleration := 0.0
var current_weapon : Weapon
var player_fsm_states : Array[State]
var player_hp_component : HPComponent
var weapon_manager_current_ammo : Dictionary[Weapon.AmmoType, int]
@onready var debug_text := %DebugText
@onready var crosshair := %Crosshair
@onready var hp_bar := %HPBar
@onready var armor_bar := %ArmorBar
func set_player_postion(new_position : Vector3) -> void:
	player_position = new_position
	debug_text.update_text() 
func set_player_velocity(new_velocity : Vector3) -> void:
	player_velocity = new_velocity
	debug_text.update_text() 
func set_player_y_acceleration(new_y_acceleration : float) -> void:
	player_y_acceleration = new_y_acceleration
	debug_text.update_text() 
func set_current_weapon(new_weapon : Node3D) -> void:
	current_weapon = new_weapon
	debug_text.update_text()
	crosshair.set_weapon_spread(current_weapon.get_spread_angle_rad())
func set_player_fsm_states(new_states : Array[State]):
	player_fsm_states = new_states
func set_player_hp(player_hp:HPComponent)->void:
	player_hp_component = player_hp
	armor_bar.update()
	hp_bar.update()
func set_ammo(type:Weapon.AmmoType, value:int)->void:
	weapon_manager_current_ammo[type]= value
	debug_text.update_text()
