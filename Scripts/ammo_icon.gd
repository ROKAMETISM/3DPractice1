extends TextureRect
const SPRITE_INF := preload("uid://4v088nbqdupu")
const SPRITE_SHOTGUNSHELL := preload("uid://dk8vgbdaymhwb")
const SPRITE_ROCKET := preload("uid://cjk56strmtbjs")
const SPRITE_PLASMA := preload("uid://dvch33mp14pxy")
const SPRITE_ERROR := preload("uid://br02cukie46qh")
func set_icon(type:Weapon.AmmoType)->void:
	match type:
		Weapon.AmmoType.Inf:
			texture = SPRITE_INF
		Weapon.AmmoType.ShotgunShell:
			texture = SPRITE_SHOTGUNSHELL
		Weapon.AmmoType.Plasma:
			texture = SPRITE_PLASMA
		Weapon.AmmoType.Rocket:
			texture = SPRITE_ROCKET
		_:
			texture = SPRITE_ERROR
