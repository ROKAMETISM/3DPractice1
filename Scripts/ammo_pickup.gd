extends Collectable
const SPRITE_SHOTGUNSHELL := preload("uid://dk8vgbdaymhwb")
const SPRITE_ROCKET := preload("uid://cjk56strmtbjs")
const SPRITE_PLASMA := preload("uid://dvch33mp14pxy")
const SPRITE_ERROR := preload("uid://br02cukie46qh")

@export var ammo_type:Weapon.AmmoType=Weapon.AmmoType.ShotgunShell
@export var ammo_amount_data:Dictionary[Weapon.AmmoType,int]={
	Weapon.AmmoType.ShotgunShell : 6,
	Weapon.AmmoType.Plasma : 30,
	Weapon.AmmoType.Rocket : 4
}
@onready var sprite := $Sprite3D
func _ready() -> void:
	set_texture(ammo_type)
func _on_collect(source:CharacterBody3D)->void:
	if not source:
		return
	source.weapon_manager.update_ammo(ammo_type, ammo_amount_data[ammo_type])
func set_texture(type:Weapon.AmmoType)->void:
	match type:
		Weapon.AmmoType.ShotgunShell:
			sprite.texture = SPRITE_SHOTGUNSHELL
		Weapon.AmmoType.Plasma:
			sprite.texture = SPRITE_PLASMA
		Weapon.AmmoType.Rocket:
			sprite.texture = SPRITE_ROCKET
		_:
			sprite.texture = SPRITE_ERROR
