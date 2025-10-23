extends CharacterBody3D
const HIT_ANIMATION_DURATION := 0.3
const BOTTOM_THRESHOLD := -50.0
var hit_animation_timer := 0.0
@onready var sprite := %Sprite
@export var move_data : MoveData
@onready var fsm := %FSM
@onready var move_controller := %EnemyTestMoveController
func _ready() -> void:
	sprite.animation = "default"
	fsm.init(self, move_data, move_controller)
	move_controller.init(self)
	move_controller.set_home_position(global_position)
func _physics_process(delta: float) -> void:
	fsm.process_physics(delta)
	hit_animation_timer -= delta
	if hit_animation_timer < 0.0:
		hit_animation_timer = 0.0
		sprite.animation = "default"
func _on_hit_taken(_source:Node3D)->void:
	sprite.animation = "hit"
	hit_animation_timer = HIT_ANIMATION_DURATION
func _die() -> void:
	queue_free()
