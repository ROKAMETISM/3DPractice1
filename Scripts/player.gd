extends CharacterBody3D

var speed : float
const WALK_SPEED := 6.0
const SPRINT_SPEED := 10.0
const JUMP_VELOCITY := 5.0
const SENSITIVITY := 0.003
const AIRCONTROL := 2.0
const BASE_FOV := 90.0
const FOV_MODIFIER := 1.5
const BULLET = preload("uid://duw3fo840ycjy")
const BOTTOM_THRESHOLD := -50.0
#Get the gravity from the project settings to be synced with Rigidbody nodes.
var gravity : float = ProjectSettings.get_setting("physics/3d/default_gravity")
@onready var headpivot = %HeadPivot
@onready var camera = %Camera3D
func _ready() -> void:
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	Console.font_size = 10
func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		headpivot.rotate_y(-event.relative.x * SENSITIVITY)
		camera.rotate_x(-event.relative.y * SENSITIVITY)
		camera.rotation.x = clamp(camera.rotation.x, deg_to_rad(-89), deg_to_rad(90))
func _physics_process(delta: float) -> void:
	#Add the gravity.
	if not is_on_floor():
		velocity.y -= gravity * delta
	#Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY
	#Handle sprint.
	if Input.is_action_pressed("sprint"):
		speed = SPRINT_SPEED
	else:
		speed = WALK_SPEED
	#Get the input direction and handle the movement/deceleration.
	#As good practice, you should replace UI actions with custom gameplay actions.
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
	#FOV
	var horizontal_veolcity = velocity
	horizontal_veolcity.y = 0.0
	var velocity_clamped = clamp(horizontal_veolcity.length(), 0.5, SPRINT_SPEED * 2)
	var target_fov = BASE_FOV + FOV_MODIFIER * velocity_clamped
	camera.fov = lerp(camera.fov, target_fov, delta * 8.0)
	if Input.is_action_pressed("fire_main"):
		var bullet = BULLET.instantiate()
		bullet.global_position = headpivot.global_position
		get_tree().current_scene.add_child(bullet)
	move_and_slide()
	if global_position.y < BOTTOM_THRESHOLD:
		get_tree().reload_current_scene()
