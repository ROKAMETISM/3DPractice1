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
func fire() -> void:
	if not player:
		return
	if not weapons[current_weapon_index]:
		return
	weapons[current_weapon_index].fire()
func set_player(new_player : CharacterBody3D):
	player = new_player
	for weapon in weapons:
		weapon.player = new_player
func switch_weapon(weapon_index : int) -> void:
	if weapon_index < 0 or weapon_index >= weapons.size() :
		return
	if not player:
		return
	if not weapons[current_weapon_index]:
		return
	current_weapon_index = weapon_index
	
