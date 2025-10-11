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
	
