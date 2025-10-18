extends Area3D
@export var damage_per_sec := 4.0
func _physics_process(delta: float) -> void:
	for area in get_overlapping_areas():
		if area is EntityComponent:
			if area.is_player:
				area.take_hit(self, damage_per_sec*delta)
