##GDScript for World < Node3D.
extends Node3D
##Const holding EnemyTest : PackedScene resource
const ENEMY_TEST := preload("uid://du3tuubqmh3i8")
##Const holding EneymCacodemon : PackedScene resource
const ENEMY_CACODEMON := preload("uid://dl5ombgjk23so")
##Const holding HPPotion : PackedScene resource
const HPPotion := preload("uid://bgpam4vncl7bb")
##reference to child node : Player
@onready var player := %Player
##reference to child node : HUD
@onready var hud := %HUD
func _ready() -> void:
	#connect signals associated with HUD
	player.position_updated.connect(hud._on_player_position_updated)
	player.velocity_updated.connect(hud._on_player_velocity_updated)
	player.y_acceleration_updated.connect(hud._on_player_y_acceleration_updated)
	player.fov_updated.connect(hud._on_player_fov_updated)
	player.weapon_manager.weapon_switched.connect(hud._on_weapon_switched)
	player.weapon_manager.ammo_updated.connect(hud._on_ammo_updated)
	player.fsm.state_updated.connect(hud._on_player_fsm_state_updated)
	player.entity_component.hp_component.hp_updated.connect(hud._on_player_hp_updated)
	#init current and max ammo for HUD
	for ammo_type in Weapon.AmmoType.values():
		player.weapon_manager.ammo_updated.emit(ammo_type, player.weapon_manager.current_ammo[ammo_type])
		hud.set_max_ammo(ammo_type, player.weapon_manager.max_ammo[ammo_type])
	player.weapon_manager.switch_weapon(0)
	Console.add_command("spawn", _console_debug_spawn, 2)
	Console.add_command("set_ammo", _console_set_ammo, 2)
func _physics_process(delta: float) -> void:
	if Input.is_action_just_pressed("quit"):
		get_tree().quit()
		return
	if Input.is_action_just_pressed("restart_game"):
		get_tree().reload_current_scene()
		return

func _console_debug_spawn(param1 : String, param2 : String)->void:
	var spawn_type : PackedScene
	match param1:
		"Test":
			spawn_type = ENEMY_TEST
		"Cacodemon":
			spawn_type = ENEMY_CACODEMON
		"HPPotion":
			spawn_type = HPPotion
		_:
			Console.print_line("Invalid type")
			return
	Console.print_line("Spawning %s at : %s" %[param1, param2])
	var components = param2.split(",", false)
	if components.size() != 3:
		return
	var spawn_location : Vector3 = Vector3(float(components[0]), float(components[1]), float(components[2]))
	var new_enemy := spawn_type.instantiate()
	add_child(new_enemy)
	new_enemy.global_position = spawn_location
	
func _console_set_ammo(param1 : String, param2 : String)->void:
	var ammo_type : Weapon.AmmoType = Weapon.AmmoType.keys().find(param1) as Weapon.AmmoType
	var amount : int = int(param2)
	print(ammo_type)
	print(amount)
	player.weapon_manager.current_ammo.set(ammo_type, amount)
	player.weapon_manager.ammo_updated.emit(ammo_type, amount)
