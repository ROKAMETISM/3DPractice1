extends ProgressBar
@onready var hud := %HUD
func update()->void:
	max_value = hud.player_hp_component.get_max_hp()
	value = hud.player_hp_component.get_current_hp()
