extends Node3D
const PISTOL := preload("uid://kft8ejopthmq")
const SHOTGUN := preload("uid://bo54vd2yvkimn")
const PLASMA_RIFLE := preload("uid://cbknwst0u60ac")
const ROCKET_LAUNCHER := preload("uid://dl0bffygxg2xl")
var player : CharacterBody3D
var weapons : Array[Node3D]
var current_weapon_index := 0
@export var max_ammo : Dictionary[Weapon.AmmoType, int]
var current_ammo : Dictionary[Weapon.AmmoType, int]
signal weapon_switched(new_weapon : Weapon)
func _ready() -> void:
	weapons.append(PISTOL.instantiate())
	weapons.append(SHOTGUN.instantiate())
	weapons.append(PLASMA_RIFLE.instantiate())
	weapons.append(ROCKET_LAUNCHER.instantiate())
	for weapon in weapons:
		add_child(weapon)
	for ammo_type in Weapon.AmmoType.values():
		current_ammo.set(ammo_type, max_ammo.get(ammo_type))
	print(current_ammo)
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
	var current_weapon : Weapon = weapons[current_weapon_index]
	if player.fire_main_pressed.has_connections():
		player.fire_main_pressed.disconnect(current_weapon.fire_main_pressed)
	if player.fire_main_released.has_connections():
		player.fire_main_released.disconnect(current_weapon.fire_main_released)
	if player.fire_special_pressed.has_connections():
		player.fire_special_pressed.disconnect(current_weapon.fire_special_pressed)
	if player.fire_special_released.has_connections():
		player.fire_special_released.disconnect(current_weapon.fire_special_released)
	if current_weapon.weapon_recoil.has_connections():
		current_weapon.weapon_recoil.disconnect(player.apply_weapon_recoil)
	current_weapon.reset()
	current_weapon_index = weapon_index
	#handle new current weapon
	current_weapon = weapons[current_weapon_index]
	player.fire_main_pressed.connect(current_weapon.fire_main_pressed)
	player.fire_main_released.connect(current_weapon.fire_main_released)
	player.fire_special_pressed.connect(current_weapon.fire_special_pressed)
	player.fire_special_released.connect(current_weapon.fire_special_released)
	current_weapon.weapon_recoil.connect(player.apply_weapon_recoil)
	weapon_switched.emit(current_weapon)
	print("weapon switched to "+str(current_weapon.weapon_name))
func scroll_weapon(index_delta : int) -> void:
	var new_index := current_weapon_index + index_delta
	new_index = posmod(new_index, weapons.size())
	switch_weapon(new_index)
