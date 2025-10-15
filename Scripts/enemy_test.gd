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
var wander_destination := Vector3.ZERO
@onready var sprite = %Sprite
@export var move_data : MoveData
@onready var fsm = %FSM
@onready var move_controller = %EnemyTestMoveController
func _ready() -> void:
	sprite.animation = "default"
	fsm.init(self, move_data, move_controller)
func _physics_process(delta: float) -> void:
	fsm.process_physics(delta)
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
