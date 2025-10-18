extends Collectable
@export var heal_amount:float=5.0
func _on_collect(source:CharacterBody3D)->void:
	if not source:
		return
	source.entity_component.hp_component.heal(heal_amount)
