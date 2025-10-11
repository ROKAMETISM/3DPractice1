extends CharacterBody3D

var speed : float
const WALK_SPEED := 6.0
const SPRINT_SPEED := 10.0
const JUMP_VELOCITY := 3.9
const JUMP_ACCEL := 4.0
const SENSITIVITY := 0.003
const AIRCONTROL := 2.0
const BASE_FOV := 90.0
const FOV_MODIFIER := 1.5
const BOTTOM_THRESHOLD := -50.0
const CAMERA_INITIAL_POINTING := Vector3(0,0,-1)
#Get the gravity from the project settings to be synced with Rigidbody nodes.
var gravity : float = 12.0
var jump_initial_acceleration := 0.0
var previous_velocity_y := 0.0
var acceleration_y := 0.0
var pointing_vector := CAMERA_INITIAL_POINTING
@onready var headpivot = %HeadPivot
@onready var camera = %Camera3D
func _ready() -> void:
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	Console.font_size = 10
	%WeaponManager.set_player(self)
func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		headpivot.rotate_y(-event.relative.x * SENSITIVITY)
		camera.rotate_x(-event.relative.y * SENSITIVITY)
		camera.rotation.x = clamp(camera.rotation.x, deg_to_rad(-89), deg_to_rad(90))
func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity.y -= gravity * delta
		if jump_initial_acceleration > 0:
			velocity.y += jump_initial_acceleration * delta
			jump_initial_acceleration -= delta * 10
		elif jump_initial_acceleration < 0 :
			jump_initial_acceleration = 0
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY
		jump_initial_acceleration = JUMP_ACCEL
	if Input.is_action_pressed("sprint"):
		speed = SPRINT_SPEED
	else:
		speed = WALK_SPEED
	var input_dir = Input.get_vector("move_left", "move_right", "move_forward", "move_backward")
	var direction = (headpivot.transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if not is_on_floor():
		velocity.x = lerp(velocity.x, direction.x * speed, delta * AIRCONTROL)
		velocity.z = lerp(velocity.z, direction.z * speed, delta * AIRCONTROL)
	else:
		if direction : 
			velocity.x = direction.x * speed
			velocity.z = direction.z * speed
		else:
			velocity.x = 0.0
			velocity.z = 0.0
	var horizontal_veolcity = velocity
	horizontal_veolcity.y = 0.0
	var velocity_clamped = clamp(horizontal_veolcity.length(), 0.5, SPRINT_SPEED * 2)
	var target_fov = BASE_FOV + FOV_MODIFIER * velocity_clamped
	camera.fov = lerp(camera.fov, target_fov, delta * 10.0)
	if Input.is_action_pressed("fire_main"):
		%WeaponManager.fire()
	move_and_slide()
	if global_position.y < BOTTOM_THRESHOLD:
		get_tree().reload_current_scene()
	acceleration_y = (velocity.y - previous_velocity_y) / delta
	previous_velocity_y = velocity.y
	pointing_vector = CAMERA_INITIAL_POINTING.rotated(Vector3.RIGHT, camera.rotation.x).rotated(Vector3.UP, headpivot.rotation.y)
	
