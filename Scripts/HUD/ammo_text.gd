extends Label
var current_weapon : Weapon
var current_ammo : Dictionary[Weapon.AmmoType, int]
var max_ammo : Dictionary[Weapon.AmmoType, int]
func update()->void:
	if not current_weapon:
		text = ""
		return
	if current_weapon.ammo_type == Weapon.AmmoType.Inf:
		text = ""
		return
	text = "%d / %d"%[current_ammo[current_weapon.ammo_type], max_ammo[current_weapon.ammo_type]]
