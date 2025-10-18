extends TextureRect
const SPRITE_INF := preload("uid://4v088nbqdupu")
const SPRITE_SHOTGUNSHELL := preload("uid://dk8vgbdaymhwb")
const SPRITE_ROCKET := preload("uid://cjk56strmtbjs")
const SPRITE_PLASMA := preload("uid://dvch33mp14pxy")
func set_icon(type:Weapon.AmmoType)->void:
	match type:
		Weapon.AmmoType.Inf:
			texture = SPRITE_INF
