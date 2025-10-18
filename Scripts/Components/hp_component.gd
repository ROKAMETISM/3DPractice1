class_name HPComponent extends Resource
@export var max_hp:=1.0
var _hp := max_hp
signal hp_updated(HPComponent)
func take_damage(damage:float)->void:
	_hp-=damage
	hp_updated.emit(self)
func heal(amount:float)->void:
	_hp+=amount
	if _hp>max_hp:_hp=max_hp
	hp_updated.emit(self)
func init(hp_value:float)->void:
	max_hp=hp_value
	_hp=hp_value
func get_current_hp()->float:
	return _hp
func get_max_hp()->float:
	return max_hp
func get_hp_percent()->float:
	return _hp/max_hp
