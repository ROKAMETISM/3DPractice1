extends ProgressBar
@onready var hud := %HUD

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
func update()->void:
	max_value = hud.player_hp_component.get_max_hp()
	value = hud.player_hp_component.get_current_hp()
