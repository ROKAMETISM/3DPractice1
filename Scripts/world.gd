extends Node3D
const ENEMY_TEST := preload("uid://du3tuubqmh3i8")
const ENEMY_CACODEMON := preload("uid://dl5ombgjk23so")
@onready var player := %Player
@onready var hud := %HUD
func _ready() -> void:
	player.player_position_updated.connect(hud.set_player_postion)
	player.player_velocity_updated.connect(hud.set_player_velocity)
	player.player_y_acceleration_updated.connect(hud.set_player_y_acceleration)
	player.player_fov_updated.connect(hud.crosshair.set_fov)
	player.weapon_manager.weapon_switched.connect(hud.set_current_weapon)
	player.weapon_manager.ammo_updated.connect(hud.set_ammo)
	player.signal_fsm_state_updated.connect(hud.set_player_fsm_states)
	player.entity_component.hp_component.hp_updated.connect(hud.set_player_hp)
	player.weapon_manager.switch_weapon(0)
	for ammo_type in Weapon.AmmoType.values():
		player.weapon_manager.ammo_updated.emit(ammo_type, player.weapon_manager.current_ammo[ammo_type])
	Console.add_command("spawn", debug_spawn, 2)
func _physics_process(delta: float) -> void:
	if Input.is_action_just_pressed("quit"):
		get_tree().quit()
		return
	if Input.is_action_just_pressed("restart_game"):
		get_tree().reload_current_scene()
		return

func debug_spawn(param1 : String, param2 : String)->void:
	var spawn_type : PackedScene
	match param1:
		"Test":
			spawn_type = ENEMY_TEST
		"Cacodemon":
			spawn_type = ENEMY_CACODEMON
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
	
