##GDScript for Player < CharacterBody3D.
class_name Player extends CharacterBody3D
##camera movement mouse sensitivity
const SENSITIVITY := 0.003
##default FOV for camera
const BASE_FOV := 90.0
##FOV modifier for dynamically changing FOV based on horizontal speed.
##Only used when DynamicFOV is true
const FOV_MODIFIER := 1.5
##reload the game if player falls below this threshold
const BOTTOM_THRESHOLD := -35.0
##vector3 indicating the "forward" direction of camera.
##Not really important, could have used Vector3.FORWARD instead.
const CAMERA_INITIAL_POINTING := Vector3(0,0,-1)
##internal variable for calculating y acceleration
var _previous_velocity_y := 0.0
##y acceleration calculated by (delta_velocity.y / delta_time)
##used for debug
var acceleration_y := 0.0
##vector pointing the direction of camera
var pointing_vector := CAMERA_INITIAL_POINTING
##rotation data of camera.
##camera_rotation.x for rotate_x and
##camera_rotation.y for rotate_y then
##you get same rotation as camera.
var camera_rotation := Vector2.ZERO
##internal variable used for restricting
##weapon switch to only happen once per physics frame.
var _allow_weapon_switch := true
##set to true when player lands on ground.
##when player jumps mid air, set back to false
var can_jump_midair := true
##MoveData used for FSM 
@export var move_data : MoveData
##boolean for toggling dynamic fov
@export var dynamic_fov := false
##number of dash charges player can hold at the same time
@export var dash_charges := 2 
##cooldown time for a dash charge to recharge, in seconds
@export var dash_cooldown := 0.8
##current number of dash charges the player currently holds.
##consumed on dash
var current_dash_charge := dash_charges : set = _set_current_dash_charge
##var for holding dash recharge untile player hits groundS
var dash_charge_queue := 0
##reference to child node
@onready var headpivot :Node3D= %HeadPivot
##reference to child node
@onready var camera :Camera3D= %Camera3D
##reference to child node
@onready var weapon_manager : WeaponManager = %WeaponManager
##reference to child node
@onready var fsm :FSM= %FSM
##reference to child node
@onready var move_controller :PlayerMoveController= %PlayerMoveController
##reference to child node
@onready var weapon_vis :Sprite3D= %WeaponVisualization
##reference to child node
@onready var entity_component :EntityComponent= %EntityComponent
##signal carrying player information for debug purpose
signal position_updated(new_position : Vector3)
##signal carrying player information for debug purpose
signal velocity_updated(new_velocity : Vector3)
##signal carrying player information for debug purpose
signal y_acceleration_updated(new_y_acceleration : float)
##signal that trigger WeaponManager's firing functions
signal fire_main_pressed
##signal that trigger WeaponManager's firing functions
signal fire_main_released
##signal that trigger WeaponManager's firing functions
signal fire_special_pressed
##signal that trigger WeaponManager's firing functions
signal fire_special_released
##triggers when fov changes so that crosshair can be updated
signal fov_updated(new_fov : float)
##triggers when can_jump_midair is changed
signal can_jump_midair_updated(value : float)
##triggers on current_dash_charge setter
signal dash_charge_updated(value : int, max_value:int)
func _ready() -> void:
	#window captures mouse
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	#set debug console
	Console.font_size = 10
	#initialize weapon manager dependencies
	weapon_manager.set_player(self)
	weapon_manager.weapon_switched.connect(_on_weapon_switched)
	weapon_manager.switch_weapon(0)
	#initialized fsm
	fsm.init(self, move_data, move_controller)
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
		_rotate_camera_on_mouse_motion(event)
	#handle weapon firing inputs
	_process_weapon_fire_input()
	#handle weapon switching.
	_process_weapon_switch_input()
func _physics_process(delta: float) -> void:
	#reset _allow_weapon_switch to true so that player can switch weapon again next physics frame.
	_allow_weapon_switch = true
	#call FSM physics process
	fsm.process_physics(delta)
	#set pointing vector by rotating it with camera rotation data.
	#Maybe it can be improved using transform.basis?
	pointing_vector = CAMERA_INITIAL_POINTING.rotated(Vector3.RIGHT, camera.rotation.x).rotated(Vector3.UP, headpivot.rotation.y)
	#calculate Y acceleration for debug purpose
	acceleration_y = (velocity.y - _previous_velocity_y) / delta
	_previous_velocity_y = velocity.y
	#player information signals for debug purpose
	position_updated.emit(global_position)
	velocity_updated.emit(velocity)
	y_acceleration_updated.emit(acceleration_y)
	#process dynamic fov
	if dynamic_fov:
		_dynamic_fov(delta)
	#debug dash charges
func _process(delta: float) -> void:
	#call FSM frame process
	fsm.process_frame(delta)
##Function connected to EntityComponent.hit_taken signal.
func _on_hit_taken(_source:Node3D)->void:
	#need this function to be defined for EntityComponent to work, but currently do nothing with it.
	#Connect hurt animation and effect on this function in the future.
	print("player hurt")
##Function connected to EntityComponent.died signal
func _die() -> void:
	#reload game when player dies.
	#Connect Game over scene on this function in the future
	get_tree().reload_current_scene()
##Apply weapon recoil(in radians) as camera vertical rotation. 
func apply_weapon_recoil(recoil_amount:float)->void:
	camera.rotate_x(recoil_amount)
	camera.rotation.x = clamp(camera.rotation.x, deg_to_rad(-89), deg_to_rad(90))
	camera_rotation = Vector2(camera.rotation.x, headpivot.rotation.y)
##Connected to WeaponManager.weapon_switched signal.
##Update Weapon visualization on screen.
func _on_weapon_switched(new_weapon : Weapon):
	weapon_vis.texture = new_weapon.weapon_vis_text
	weapon_vis.visible = true
##Process picking up collectables.
func _on_pickup_range_area_entered(area: Area3D) -> void:
	#check if colliding Area3D is actually a collectable.
	#I won't need this thanks to collision layers, but just in case.
	if not(area is Collectable):
		print("object not collectable : %s"%area)
		return
	#cast area as Collectable just for code autocompletion and compiler helps
	var collectable : Collectable = area as Collectable
	#every Collectable object has this function : Collectable.collect(Node)
	#Collectable handles what happens when player picks it up.
	collectable.collect(self)
##rotate camera using mouse motion. event should be InputEventMouseMotion.
func _rotate_camera_on_mouse_motion(event : InputEventMouseMotion)->void:
	headpivot.rotate_y(-event.relative.x * SENSITIVITY)
	camera.rotate_x(-event.relative.y * SENSITIVITY)
	#cap vertical rotation to -89 degrees and +90 degrees
	camera.rotation.x = clamp(camera.rotation.x, deg_to_rad(-89), deg_to_rad(90))
	#save camera rotation data to Vector2 camera_rotation
	camera_rotation = Vector2(camera.rotation.x, headpivot.rotation.y)
##handle weawpon firing inputs and transfer them to weapon manager using signals.
##since this function is called every unhandled input, assume that no input is simultaneous.
func _process_weapon_fire_input()->void:
	if Input.is_action_just_pressed("fire_main"):
		fire_main_pressed.emit()
		return
	if Input.is_action_just_released("fire_main"):
		fire_main_released.emit()
		return
	if Input.is_action_just_pressed("fire_special"):
		fire_special_pressed.emit()
		return
	if Input.is_action_just_released("fire_special"):
		fire_special_released.emit()
		return
##handle weapon switching inputs. _allow_weapon_switch resets to true every physics frame
func _process_weapon_switch_input()->void:
	#if _allow_weapon_switch == false then do not switch
	if not _allow_weapon_switch:
		return
	if Input.is_action_just_pressed("switch_weapon_next"):
		weapon_manager.scroll_weapon(1)
		_allow_weapon_switch = false
		return
	if Input.is_action_just_pressed("switch_weapon_previous"):
		weapon_manager.scroll_weapon(-1)
		_allow_weapon_switch = false
		return
##Change FOV dynamically using horizontal velocity
##only call this function if dynamic_fov is true.
func _dynamic_fov(delta:float)->void:
	var horizontal_veolcity = velocity
	horizontal_veolcity.y = 0.0
	var velocity_clamped = clamp(horizontal_veolcity.length(), 0.5, move_data.sprint_speed * 2)
	var target_fov = BASE_FOV + FOV_MODIFIER * velocity_clamped
	camera.fov = lerp(camera.fov, target_fov, delta * 10.0)
	fov_updated.emit(camera.fov)
func _set_current_dash_charge(value : int)->void:
	current_dash_charge = clamp(value, 0, dash_charges)
	dash_charge_updated.emit(current_dash_charge, dash_charges)
