extends CharacterBody2D
enum State {
	Idle,
	Move,
	qwerre
}
var move_state
var vertical_state
var attack_state
var current_states : Array[State]

func _physics_process(_delta: float) -> void:
	for state : State in current_states:
		match state:
			"move":
				pass
			"idle":
				pass
			"jump":
				pass
