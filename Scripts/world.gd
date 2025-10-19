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
	#set player weapon to weapon[0] so that connected signals initialize.
	player.weapon_manager.switch_weapon(0)
	player.fov_updated.emit(player.BASE_FOV)
	#setup console commands
	Console.add_command("spawn", _console_debug_spawn, 2)
	Console.add_command("set_ammo", _console_set_ammo, 2)
func _physics_process(delta: float) -> void:
	#quit game when "quit" action is pressed
	if Input.is_action_just_pressed("quit"):
		get_tree().quit()
		return
	#reload game when "restart_game" action is pressed.
	if Input.is_action_just_pressed("restart_game"):
		get_tree().reload_current_scene()
		return
##Spawns an entity(param1) on given location(param2).
##Give entity name via param1. Currently available entities : 
##Test, Cacodemon, HPPotion.  
##Give lovation via param2. Format example : 
##1,2,3 : spawns the entity at global_position Vector3(1,2,3). 
func _console_debug_spawn(param1 : String, param2 : String)->void:
	##Holds PackedScene resource used for spawning entities.
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
	##Try to parse param2 as Vector3
	var components : Array = param2.split(",", false)
	if components.size() != 3:
		Console.print_line("Unable to parse location")
		return
	##Cast each element of components as float and save it as Vector3.
	var spawn_location : Vector3 = Vector3(float(components[0]), float(components[1]), float(components[2]))
	##Entity instance
	var new_entity := spawn_type.instantiate()
	#add the entity as child of World scene root node, which is the current node.
	add_child(new_entity)
	#set its global position to given spawn location.
	new_entity.global_position = spawn_location
##Set ammo value for given ammo type.
##Give ammo type as param1. For example : 
##ShotgunShell, Plasma, Rocket
##Give ammo value as param2 in int.
func _console_set_ammo(param1 : String, param2 : String)->void:
	#First, check if param1 is an actual AmmoType name
	if not Weapon.AmmoType.keys().has(param1):
		Console.print_line("AmmoType not found")
		return
	##param1 is ammo_type name as string. Find it in the AmmoType enum keys, and cast it as AmmoType
	var ammo_type : Weapon.AmmoType = Weapon.AmmoType.keys().find(param1) as Weapon.AmmoType
	##ammo value is param2 cast to int.
	##if param2 is invalid int, amount is automatically 0.
	var amount : int = int(param2)
	Console.print_line("Set %s ammo to : %d"%[param1, amount])
	#set the ammo value to amount
	player.weapon_manager.current_ammo.set(ammo_type, amount)
	#update the changes
	player.weapon_manager.ammo_updated.emit(ammo_type, amount)
