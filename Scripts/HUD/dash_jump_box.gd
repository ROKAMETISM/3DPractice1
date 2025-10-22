extends HBoxContainer
@onready var dash_icons : Array[TextureRect]
@onready var DashIcon1 := %DashIcon1
@onready var DashIcon2 := %DashIcon2
var max_dash_charge := 2
const ICON_ON := preload("uid://bnjbba6fwid86")
const ICON_OFF := preload("uid://852sroacxeal")
func _ready() -> void:
	dash_icons.append(DashIcon1)
	dash_icons.append(DashIcon2)
func update_dash(value:int, max_value:int)->void:
	max_dash_charge = max_value
	for i in range(0, value):
		dash_icons[i].texture = ICON_ON
	for i in range(value, max_dash_charge):
		dash_icons[i].texture = ICON_OFF
