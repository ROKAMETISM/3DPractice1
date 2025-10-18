class_name HPComponent extends Resource
@export var max_hp:=1.0
var _hp := max_hp
signal hp_updated(HPComponent)
func take_damage(damage:float)->void:
	_hp-=damage
	hp_updated.emit(self)
func init(hp_value:float)->void:
	max_hp=hp_value
	_hp=hp_value
