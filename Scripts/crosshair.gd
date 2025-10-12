extends TextureRect
const CIRCLE_COLOR := Color(0.0, 1.0, 1.0, 0.7)
var _weapon_spread := -1.0
var _fov := 75.0

func _draw() -> void:
	if _weapon_spread <= 0.0:
		return
	var viewport_dimension : Vector2 = get_viewport_rect().size
	var spread_radius : float = min(viewport_dimension.x, viewport_dimension.y)
	spread_radius = spread_radius / 2 * (tan(_weapon_spread) / tan(deg_to_rad(_fov / 2)))
	draw_circle(size/2+Vector2(-0.5,-0.5), spread_radius, CIRCLE_COLOR, false, -1.0, false)
func set_weapon_spread(weapon_spread:float)->void:
	_weapon_spread=weapon_spread
	queue_redraw()
func set_fov(new_fov : float) -> void:
	_fov = new_fov
	queue_redraw()
