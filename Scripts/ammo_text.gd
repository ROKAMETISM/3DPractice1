extends Label
@onready var hud := %HUD
func update()->void:
	if not hud.current_weapon:
		text = ""
		return
	if hud.current_weapon.ammo_type == Weapon.AmmoType.Inf:
		text = ""
		return
	text = "%d / %d"%[hud.current_ammo[hud.current_weapon.ammo_type], hud.max_ammo[hud.current_weapon.ammo_type]]
