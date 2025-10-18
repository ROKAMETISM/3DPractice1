extends Node3D
const ENEMY_TEST := preload("uid://du3tuubqmh3i8")
@onready var player := %Player
@onready var hud := %HUD
func _ready() -> void:
	player.player_position_updated.connect(hud.set_player_postion)
	player.player_velocity_updated.connect(hud.set_player_velocity)
	player.player_y_acceleration_updated.connect(hud.set_player_y_acceleration)
	player.weapon_manager.weapon_switched.connect(hud.set_current_weapon)
	player.player_fov_updated.connect(hud.crosshair.set_fov)
	player.signal_fsm_state_updated.connect(hud.set_player_fsm_states)
	player.weapon_manager.switch_weapon(0)
	player.entity_component.hp_component.hp_updated.connect(hud.set_player_hp)
	Console.add_command("SpawnEnemyTest", spawn_enemy_test, 1)

func _physics_process(delta: float) -> void:
	if Input.is_action_just_pressed("quit"):
		get_tree().quit()
		return
	if Input.is_action_just_pressed("restart_game"):
		get_tree().reload_current_scene()
		return

func spawn_enemy_test(param : String)->void:
	Console.print_line("Spawning at : %s" % str(param))
	var components = param.split(",", false)
	if components.size() != 3:
		return
	var spawn_location : Vector3 = Vector3(float(components[0]), float(components[1]), float(components[2]))
	var new_enemy := ENEMY_TEST.instantiate()
	add_child(new_enemy)
	new_enemy.global_position = spawn_location
	
