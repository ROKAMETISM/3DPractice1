extends Area2D
class_name Hitbox
var self_move := [0,0,0]
var colliding_bodies : Array[CharacterBody2D]
signal my_signal
signal another_signal
func _ready() -> void:
	my_signal.connect(my_func.bind(3))
	another_signal.connect(my_func)
	my_signal.emit()
	another_signal.emit(5)
var mytimer = Timer.new()

func init_timer()->void:
	mytimer.autostart= false
	connect(mytimer.timeout, my_func.bind(1))
	mytimer.timeout.connect(my_func)
func _physics_process(delta: float) -> void:
	if mytimer.is_stopped():
		pass
		randomize()
		mytimer.wait_time = self_move[2]
		mytimer.start()
	
func my_func(arg : int)->void:
	pass
