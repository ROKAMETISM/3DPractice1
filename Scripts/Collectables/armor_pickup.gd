extends Collectable
@export var armor_amount:float=15.0
func _on_collect(source:CharacterBody3D)->void:
	if not source:
		return
	source.entity_component.hp_component.add_armor(armor_amount)
