class_name Player extends CharacterBody3D
#camera movement mouse sensitivity
const SENSITIVITY := 0.003
#default FOV for camera
const BASE_FOV := 90.0
#FOV modifier for dynamically changing FOV based on horizontal speed. Only used when DynamicFOV is true
const FOV_MODIFIER := 1.5
#reload the game if player falls below this threshold
const BOTTOM_THRESHOLD := -35.0
#vector3 indicating the "forward" direction of camera. Not really important, could have used Vector3.FORWARD instead.
const CAMERA_INITIAL_POINTING := Vector3(0,0,-1)
#internal variable for calculating y acceleration
var _previous_velocity_y := 0.0
#y acceleration calculated by (delta_velocity.y / delta_time). used for debug
var acceleration_y := 0.0
#vector pointing the direction of camera
var pointing_vector := CAMERA_INITIAL_POINTING
#rotation data of camera. Vector2.x for rotate_x and Vector2.y for rotate_y and you get same rotation as camera.
var camera_rotation := Vector2.ZERO
#internal variable used for restricting weapon switch to only happen once per physics frame.
var _allow_weapon_switch := true
#same as fsm.fsm_state_updated:Signal, but I don't know why I have this as variable here.
var signal_fsm_state_updated : Signal
#MoveData used for FSM 
@export var move_data : MoveData
#boolean for toggling dynamic fov
@export var dynamic_fov := false
#references to child classes
@onready var headpivot := %HeadPivot
@onready var camera := %Camera3D
@onready var weapon_manager : WeaponManager = %WeaponManager
@onready var fsm := %FSM
@onready var move_controller := %PlayerMoveController
@onready var weapon_vis := %WeaponVisualization
@onready var entity_component := %EntityComponent
#signals carrying player information for debug perpose
signal player_position_updated(new_position : Vector3)
signal player_velocity_updated(new_velocity : Vector3)
signal player_y_acceleration_updated(new_y_acceleration : float)
#signals that trigger WeaponManager and current weapon's firing functions
signal fire_main_pressed
signal fire_main_released
signal fire_special_pressed
signal fire_special_released
#triggers when fov changes so that crosshair can be updated
signal player_fov_updated(new_fov : float)
func _ready() -> void:
	#window captures mouse
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	#set debug console
	Console.font_size = 10
	#initialize weapon manager dependencies
	weapon_manager.set_player(self)
	weapon_manager.switch_weapon(0)
	weapon_manager.weapon_switched.connect(update_weapon)
	#initialized fsm
	fsm.init(self, move_data, move_controller)
	signal_fsm_state_updated = fsm.fsm_state_updated
	#initialize move controller
	move_controller.init(self)
	#initialize camera fov
	camera.fov = BASE_FOV
	#lazy way of emitting signal fov_updated
	_dynamic_fov(0.0)
func _unhandled_input(event: InputEvent) -> void:
	#transfer input to fsm so that it can be processed
	fsm.process_input(event)
	#rotate camera according to mouse movement
	if event is InputEventMouseMotion:
		_rotate_camera(event)
	#handle weawpon firing inputs and transfer them to weapon manager using signals
	if Input.is_action_just_pressed("fire_main"):
		fire_main_pressed.emit()
	if Input.is_action_just_released("fire_main"):
		fire_main_released.emit()
	if Input.is_action_just_pressed("fire_special"):
		fire_special_pressed.emit()
	if Input.is_action_just_released("fire_special"):
		fire_special_released.emit()
	#handle weapon switching. _allow_weapon_switch resets to true every physics frame
	if Input.is_action_just_pressed("switch_weapon_next") and _allow_weapon_switch:
		weapon_manager.scroll_weapon(1)
		_allow_weapon_switch = false
	if Input.is_action_just_pressed("switch_weapon_previous") and _allow_weapon_switch:
		weapon_manager.scroll_weapon(-1)
		_allow_weapon_switch = false
func _physics_process(delta: float) -> void:
	is_on_wall()
	_allow_weapon_switch = true
	fsm.process_physics(delta)
	acceleration_y = (velocity.y - _previous_velocity_y) / delta
	_previous_velocity_y = velocity.y
	pointing_vector = CAMERA_INITIAL_POINTING.rotated(Vector3.RIGHT, camera.rotation.x).rotated(Vector3.UP, headpivot.rotation.y)
	player_position_updated.emit(global_position)
	player_velocity_updated.emit(velocity)
	player_y_acceleration_updated.emit(acceleration_y)
	if dynamic_fov:
		_dynamic_fov(delta)
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
	if not(area is Collectable):
		print("object not collectable : %s"%area)
		return
	area.collect(self)
##rotate camera using mouse motion. event should be InputEventMouseMotion.
func _rotate_camera(event : InputEventMouseMotion)->void:
	headpivot.rotate_y(-event.relative.x * SENSITIVITY)
	camera.rotate_x(-event.relative.y * SENSITIVITY)
	#cap vertical rotation to -89 degrees and +90 degrees
	camera.rotation.x = clamp(camera.rotation.x, deg_to_rad(-89), deg_to_rad(90))
	#save camera rotation data to Vector2 camera_rotation
	camera_rotation = Vector2(camera.rotation.x, headpivot.rotation.y)
func _dynamic_fov(delta:float)->void:
	var horizontal_veolcity = velocity
	horizontal_veolcity.y = 0.0
	var velocity_clamped = clamp(horizontal_veolcity.length(), 0.5, move_data.sprint_speed * 2)
	var target_fov = BASE_FOV + FOV_MODIFIER * velocity_clamped
	camera.fov = lerp(camera.fov, target_fov, delta * 10.0)
	player_fov_updated.emit(camera.fov)
