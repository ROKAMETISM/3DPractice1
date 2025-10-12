extends TextureRect
var _weapon_spread := -1.0
var FOV := 75.0
func _draw() -> void:
	if _weapon_spread <= 0.0:
		return
	var viewport_dimension : Vector2 = get_viewport_rect().size
	var spread_radius : float = min(viewport_dimension.x, viewport_dimension.y)
	spread_radius = spread_radius * (tan(_weapon_spread) / tan(FOV / 2))
	print("WeaponSpread:%.2f"%_weapon_spread)
	print("FOV / 2 :%.2f"%(FOV/2))
	print("Spread Radius:%.2f"%spread_radius)
	draw_circle(size/2+Vector2(-0.5,-0.5), spread_radius, Color.WHITE, false, 1.0, true)
func set_weapon_spread(weapon_spread:float)->void:
	_weapon_spread=weapon_spread
	queue_redraw()
func set_fov(new_fov : float) -> void:
	FOV = new_fov
	queue_redraw()
