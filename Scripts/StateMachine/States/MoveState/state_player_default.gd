class_name PlayerDefaultState extends State
@export var player_dash_state : PlayerDashState
@export var grounded_state : GroundedState
var _dash_recharge_timer := 0.0
func enter() -> void:
	super()
func process_input(_event: InputEvent) -> Array:
	var _output : Array
	if move_controller.dash_input():
		if fsm_get_current_states().has(player_dash_state):
			return _output
		if parent.current_dash_charge <= 0:
			return _output
		parent.current_dash_charge -= 1
		for state in fsm_get_current_states():
			if state == self:
				continue
			_output.append(Transition.new(state,Transition.Type.Exit))
		_output.append(Transition.new(player_dash_state, Transition.Type.Enter))
	return _output
func process_physics(delta: float) -> Array:
	var _output : Array
	_recharge_dash(delta)
	return _output
func get_state_name()->String:
	return "PlayerDefault"
func _recharge_dash(delta:float)->void:
	if parent.current_dash_charge + parent.dash_charge_queue >= parent.dash_charges:
		return
	_dash_recharge_timer -= delta
	if _dash_recharge_timer <= 0.0:
		_dash_recharge_timer = parent.dash_cooldown
		parent.dash_charge_queue += 1
	if not fsm_get_current_states().has(grounded_state):
		return
	if parent.dash_charge_queue > 0:
		parent.current_dash_charge += parent.dash_charge_queue
		parent.dash_charge_queue = 0
