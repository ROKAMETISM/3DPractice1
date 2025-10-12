extends CharacterBody3D
const SPEED := 5.0
const JUMP_VELOCITY := 4.5
const MAX_HP := 10.0
const HIT_ANIMATION_DURATION := 0.3
const GRAVITY := 10.0
var current_hp := MAX_HP
var hit_animation_timer := 0.0
var ai_state := state.PAUSE
@onready var sprite = %Sprite
enum state {
	WANDER,
	PAUSE
}
func _ready() -> void:
	sprite.animation = "default"
func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity.y -= GRAVITY * delta
	move_and_slide()
	hit_animation_timer -= delta
	if hit_animation_timer < 0.0:
		hit_animation_timer = 0.0
		sprite.animation = "default"
func iterate_ai()->void:
	pass
func take_damage(damage : float) -> void:
	current_hp -= damage
	if current_hp <= 0.0:
		_die()
		return
	sprite.animation = "hit"
	hit_animation_timer = HIT_ANIMATION_DURATION
func _die() -> void:
	queue_free()
