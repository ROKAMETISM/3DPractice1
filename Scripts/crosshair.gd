extends TextureRect
var _weapon_spread := -1.0
func _draw() -> void:
	if _weapon_spread <= 0.0:
		return
	draw_circle(size/2+Vector2(-0.5,-0.5), _weapon_spread, Color.WHITE, false, -1.0, true)
func set_weapon_spread(weapon_spread:float)->void:
	_weapon_spread=weapon_spread
	queue_redraw()
