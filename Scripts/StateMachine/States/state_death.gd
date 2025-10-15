class_name DeathState
extends State
func enter() -> void:
	super()
	parent._die()
func get_state_name()->String:
	return "Death"
