extends Node3D
const PISTOLPRELOAD := preload("uid://kft8ejopthmq")
const SHOTGUNPRELOAD := preload("uid://bo54vd2yvkimn")
var player : CharacterBody3D
var weapons : Array[Node3D]
var current_weapon_index := 0
signal weapon_switched(new_weapon : Node3D)
func _ready() -> void:
	var pistol := PISTOLPRELOAD.instantiate()
	var shotgun := SHOTGUNPRELOAD.instantiate()
	weapons.append(pistol)
	weapons.append(shotgun)
	for weapon in weapons:
		add_child(weapon)
		weapon.player = player
func _physics_process(delta: float) -> void:
	for weapon in weapons:
		weapon.pointing_vector = player.pointing_vector
		weapon.adjusted_rotation = player.camera_rotation
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
	if weapon_index < 0 or weapon_index >= weapons.size() :
		return
	if not player:
		return
	if not weapons[current_weapon_index]:
		return
	if player.fire_main_pressed.has_connections():
		player.fire_main_pressed.disconnect(weapons[current_weapon_index].fire_main_pressed)
	if player.fire_main_released.has_connections():
		player.fire_main_released.disconnect(weapons[current_weapon_index].fire_main_released)
	print("weapon switched to "+str(weapons[current_weapon_index].WEAPON_NAME))
	current_weapon_index = weapon_index
	player.fire_main_pressed.connect(weapons[current_weapon_index].fire_main_pressed)
	player.fire_main_released.connect(weapons[current_weapon_index].fire_main_released)
	weapon_switched.emit(weapons[current_weapon_index])
func scroll_weapon(index_delta : int) -> void:
	var new_index := current_weapon_index + index_delta
	new_index = posmod(new_index, weapons.size())
	switch_weapon(new_index)
