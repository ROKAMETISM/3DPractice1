extends CharacterBody3D

const SPEED := 5.0
const JUMP_VELOCITY := 4.5
#Get the gravity from the project settings to be synced with Rigidbody nodes.
var gravity : float = ProjectSettings.get_setting("physics/3d/default_gravity")
func _physics_process(delta: float) -> void:
	#Add the gravity.
	if not is_on_floor():
		velocity.y -= gravity * delta
	#Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY
	#Get the input direction and handle the movement/deceleration.
	#As good practice, you should replace UI actions with custom gameplay actions.
	var input_dir = Input.get_vector("move_left", "move_right", "move_forward", "move_backward")
