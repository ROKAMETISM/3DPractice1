class_name PlayerDefaultState extends State
@export var player_dash_state : PlayerDashState
func enter() -> void:
	super()
func process_input(_event: InputEvent) -> Array:
	var _output : Array
	if move_controller.dash_input():
		if fsm_get_current_states().has(player_dash_state):
			return _output
		for state in fsm_get_current_states():
			if state == self:
				continue
			_output.append(Transition.new(state,Transition.Type.Exit))
		_output.append(Transition.new(player_dash_state, Transition.Type.Enter))
	return _output
func process_physics(_delta: float) -> Array:
	var _output : Array
	return _output
func get_state_name()->String:
	return "PlayerDefault"
