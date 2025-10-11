extends CharacterBody3D
const SPEED := 5.0
const JUMP_VELOCITY := 4.5
const MAX_HP := 10.0
const HIT_ANIMATION_DURATION := 0.5
var current_hp := MAX_HP
var hit_animation_timer := 0.0
@onready var sprite = %Sprite
func _ready() -> void:
	sprite.animation = "default"
func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
	move_and_slide()
	hit_animation_timer -= delta
	if hit_animation_timer < 0.0:
		hit_animation_timer = 0.0
		sprite.animation = "default"
func take_damage(damage : float) -> void:
	current_hp -= damage
	if current_hp <= 0.0:
		_die()
		return
	sprite.animation = "hit"
	hit_animation_timer = HIT_ANIMATION_DURATION
func _die() -> void:
	queue_free()
