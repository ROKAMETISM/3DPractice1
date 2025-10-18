class_name Player extends CharacterBody3D

const SENSITIVITY := 0.003
const BASE_FOV := 90.0
const FOV_MODIFIER := 1.5
const BOTTOM_THRESHOLD := -50.0
const CAMERA_INITIAL_POINTING := Vector3(0,0,-1)
var _previous_velocity_y := 0.0
var acceleration_y := 0.0
var pointing_vector := CAMERA_INITIAL_POINTING
var camera_rotation := Vector2.ZERO
var _allow_weapon_switch := true
var signal_fsm_state_updated : Signal
@export var move_data : MoveData
@onready var headpivot := %HeadPivot
@onready var camera := %Camera3D
@onready var weapon_manager := %WeaponManager
@onready var fsm := %FSM
@onready var move_controller := %PlayerMoveController
@onready var weapon_vis := %WeaponVisualization
@onready var entity_component := %EntityComponent
signal player_position_updated(new_position : Vector3)
signal player_velocity_updated(new_velocity : Vector3)
signal player_y_acceleration_updated(new_y_acceleration : float)
signal fire_main_pressed
signal fire_main_released
signal fire_special_pressed
signal fire_special_released
signal player_fov_updated(new_fov : float)
func _ready() -> void:
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	Console.font_size = 10
	weapon_manager.set_player(self)
	weapon_manager.switch_weapon(0)
	weapon_manager.weapon_switched.connect(update_weapon)
	fsm.init(self, move_data, move_controller)
	move_controller.init(self)
	signal_fsm_state_updated = fsm.fsm_state_updated
func _unhandled_input(event: InputEvent) -> void:
	fsm.process_input(event)
	if event is InputEventMouseMotion:
		headpivot.rotate_y(-event.relative.x * SENSITIVITY)
		camera.rotate_x(-event.relative.y * SENSITIVITY)
		camera.rotation.x = clamp(camera.rotation.x, deg_to_rad(-89), deg_to_rad(90))
		camera_rotation = Vector2(camera.rotation.x, headpivot.rotation.y)
	if Input.is_action_just_pressed("fire_main"):
		fire_main_pressed.emit()
	if Input.is_action_just_released("fire_main"):
		fire_main_released.emit()
	if Input.is_action_just_pressed("fire_special"):
		fire_special_pressed.emit()
	if Input.is_action_just_released("fire_special"):
		fire_special_released.emit()
	if Input.is_action_just_pressed("switch_weapon_next") and _allow_weapon_switch:
		weapon_manager.scroll_weapon(1)
		_allow_weapon_switch = false
	if Input.is_action_just_pressed("switch_weapon_previous") and _allow_weapon_switch:
		weapon_manager.scroll_weapon(-1)
		_allow_weapon_switch = false
func _physics_process(delta: float) -> void:
	_allow_weapon_switch = true
	fsm.process_physics(delta)
	acceleration_y = (velocity.y - _previous_velocity_y) / delta
	_previous_velocity_y = velocity.y
	pointing_vector = CAMERA_INITIAL_POINTING.rotated(Vector3.RIGHT, camera.rotation.x).rotated(Vector3.UP, headpivot.rotation.y)
	player_position_updated.emit(global_position)
	player_velocity_updated.emit(velocity)
	player_y_acceleration_updated.emit(acceleration_y)
	var horizontal_veolcity = velocity
	horizontal_veolcity.y = 0.0
	var velocity_clamped = clamp(horizontal_veolcity.length(), 0.5, move_data.sprint_speed * 2)
	var target_fov = BASE_FOV + FOV_MODIFIER * velocity_clamped
	camera.fov = lerp(camera.fov, target_fov, delta * 10.0)
	player_fov_updated.emit(camera.fov)
func _process(delta: float) -> void:
	fsm.process_frame(delta)
func _on_hit_taken(source:Node3D)->void:
	print("player hurt")
func _die() -> void:
	get_tree().reload_current_scene()
func apply_weapon_recoil(recoil_amount:float)->void:
	camera.rotate_x(recoil_amount)
	camera.rotation.x = clamp(camera.rotation.x, deg_to_rad(-89), deg_to_rad(90))
	camera_rotation = Vector2(camera.rotation.x, headpivot.rotation.y)
func update_weapon(new_weapon : Weapon):
	weapon_vis.texture = new_weapon.weapon_vis_text
	weapon_vis.visible = true
func _on_pickup_range_area_entered(area: Area3D) -> void:
	if not area is Collectable:
		return
	area.collect(self)
