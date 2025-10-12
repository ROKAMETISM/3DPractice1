extends Node3D
const PISTOLPRELOAD := preload("uid://kft8ejopthmq")
var player : CharacterBody3D
var weapons : Array[Node3D]
var current_weapon_index := 0
func _ready() -> void:
	var pistol := PISTOLPRELOAD.instantiate()
	add_child(pistol)
	weapons.append(pistol)
	pistol.player = player
func fire_main() -> void:
	if not player:
		return
	if not weapons[current_weapon_index]:
		return
	weapons[current_weapon_index].fire_main_repeated()
func set_player(new_player : CharacterBody3D):
	player = new_player
	for weapon in weapons:
		weapon.player = new_player
func switch_weapon(weapon_index : int) -> void:
	print("switchweapon called")
	if weapon_index < 0 or weapon_index >= weapons.size() :
		return
	if not player:
		return
	if not weapons[current_weapon_index]:
		return
	print("switching weapon")
	if player.fire_main_pressed.has_connections():
		player.fire_main_pressed.disconnect(weapons[current_weapon_index].fire_main_pressed)
	if player.fire_main_released.has_connections():
		player.fire_main_released.disconnect(weapons[current_weapon_index].fire_main_released)
	current_weapon_index = weapon_index
	player.fire_main_pressed.connect(weapons[current_weapon_index].fire_main_pressed)
	player.fire_main_released.connect(weapons[current_weapon_index].fire_main_released)
	
