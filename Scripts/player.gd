extends CharacterBody3D

var speed : float
const WALK_SPEED := 5.0
const SPRINT_SPEED := 7.0
const JUMP_VELOCITY := 4.5
const SENSITIVITY := 0.003
#Get the gravity from the project settings to be synced with Rigidbody nodes.
var gravity : float = ProjectSettings.get_setting("physics/3d/default_gravity")
@onready var headpivot = %HeadPivot
@onready var camera = %Camera3D
func _ready() -> void:
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
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
	if direction : 
		velocity.x = direction.x * speed
		velocity.z = direction.z * speed
	else:
		velocity.x = 0.0
		velocity.z = 0.0
	move_and_slide()
