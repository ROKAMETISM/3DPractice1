extends TextureRect
const ON_TEXTURE := preload("uid://dwud3kfhb2cdq")
const OFF_TEXTURE := preload("uid://ckpgplf882a8w")
func _set_state(state : bool) -> void:
	if state:
		texture = ON_TEXTURE
	else:
		texture = OFF_TEXTURE
