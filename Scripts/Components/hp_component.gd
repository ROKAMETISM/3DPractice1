class_name HPComponent extends Resource
@export var max_hp:=1.0
var _hp := max_hp
signal hit_taken
signal hp_updated(HPComponent)
signal died
func take_damage(damage:float)->void:
	_hp-=damage
	hit_taken.emit()
	hp_updated.emit(self)
	if _hp <= 0.0:
		died.emit()
