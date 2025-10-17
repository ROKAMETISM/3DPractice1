extends Node3D
const PISTOL := preload("uid://kft8ejopthmq")
const SHOTGUN := preload("uid://bo54vd2yvkimn")
const PLASMA_RIFLE := preload("uid://cbknwst0u60ac")
var player : CharacterBody3D
var weapons : Array[Node3D]
var current_weapon_index := 0
signal weapon_switched(new_weapon : Node3D)
func _ready() -> void:
	weapons.append(PISTOL.instantiate())
	weapons.append(SHOTGUN.instantiate())
	weapons.append(PLASMA_RIFLE.instantiate())
	for weapon in weapons:
		add_child(weapon)
func _physics_process(delta: float) -> void:
	for weapon in weapons:
		weapon.set_direction(player.pointing_vector, player.camera_rotation)
func set_player(new_player : CharacterBody3D):
	player = new_player
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
	if player.fire_special_pressed.has_connections():
		player.fire_special_pressed.disconnect(weapons[current_weapon_index].fire_special_pressed)
	if player.fire_special_released.has_connections():
		player.fire_special_released.disconnect(weapons[current_weapon_index].fire_special_released)
	weapons[current_weapon_index].reset()
	current_weapon_index = weapon_index
	player.fire_main_pressed.connect(weapons[current_weapon_index].fire_main_pressed)
	player.fire_main_released.connect(weapons[current_weapon_index].fire_main_released)
	player.fire_special_pressed.connect(weapons[current_weapon_index].fire_special_pressed)
	player.fire_special_released.connect(weapons[current_weapon_index].fire_special_released)
	weapon_switched.emit(weapons[current_weapon_index])
	print("weapon switched to "+str(weapons[current_weapon_index].weapon_name))
func scroll_weapon(index_delta : int) -> void:
	var new_index := current_weapon_index + index_delta
	new_index = posmod(new_index, weapons.size())
	switch_weapon(new_index)
