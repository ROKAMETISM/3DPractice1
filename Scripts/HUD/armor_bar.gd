extends ProgressBar
var player_hp_component : HPComponent
func update()->void:
	max_value = player_hp_component.get_max_armor()
	value = player_hp_component.get_current_armor()
