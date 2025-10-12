extends CharacterBody3D
const SPEED := 2.0
const JUMP_VELOCITY := 4.5
const MAX_HP := 10.0
const HIT_ANIMATION_DURATION := 0.3
const GRAVITY := 10.0
const PAUSE_TIME := 8.0
const PAUSE_TIME_SPREAD := 2.0
const WANDER_RADIUS := 16.0
const WANDER_DESTINATION_REACH_THRESHOLD := 5.0
var current_hp := MAX_HP
var hit_animation_timer := 0.0
var current_state := state.PAUSE
var wander_destination := Vector3.ZERO
@onready var sprite = %Sprite
enum state {
	WANDER,
	PAUSE
}
func _ready() -> void:
	sprite.animation = "default"
	_start_wander()
func _physics_process(delta: float) -> void:
	# Add the gravity.
	iterate_ai()
	if not is_on_floor():
		velocity.y -= GRAVITY * delta
	move_and_slide()
	hit_animation_timer -= delta
	if hit_animation_timer < 0.0:
		hit_animation_timer = 0.0
		sprite.animation = "default"
func iterate_ai()->void:
	if current_state == state.PAUSE:
		return
	if current_state == state.WANDER:
		look_at(wander_destination, Vector3.UP)
		velocity = -transform.basis.z*SPEED
		if (wander_destination-global_position).length() < WANDER_DESTINATION_REACH_THRESHOLD:
			current_state = state.PAUSE
			print("wander destination reached")
			get_tree().create_timer(PAUSE_TIME+randf_range(-1.0, 1.0)*PAUSE_TIME_SPREAD).timeout.connect(_pause_timer_timeout)
func take_damage(damage : float) -> void:
	current_hp -= damage
	if current_hp <= 0.0:
		_die()
		return
	sprite.animation = "hit"
	hit_animation_timer = HIT_ANIMATION_DURATION
func _die() -> void:
	queue_free()
func _get_next_wander_position()->Vector3:
	print("get new wander destination")
	var dist := sqrt(randf())*WANDER_RADIUS
	return Vector3(dist, 0.0, 0.0).rotated(Vector3.UP, randf_range(0.0, 2*PI))
func _pause_timer_timeout()->void:
	_start_wander()
func _start_wander()->void:
	current_state = state.WANDER
	wander_destination = _get_next_wander_position()
