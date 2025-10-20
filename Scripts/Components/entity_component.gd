class_name EntityComponent extends Area3D
@export var is_enemy := true
@export var is_player := false
@export var max_hp := 1.0
@export var max_armor:=0.0
@onready var parent := get_parent()
@onready var hp_component := HPComponent.new()
signal hit_taken(hit_source:Node3D)
signal died
func _ready() -> void:
	hp_component.init(max_hp,  max_armor)
	collision_layer = 0b0
	collision_mask = 0b0
	if is_enemy:
		set_collision_layer_value(5, true)
	if is_player:
		set_collision_layer_value(3, true)
	hp_component.hp_updated.connect(_on_hp_updated)
	hit_taken.connect(parent._on_hit_taken)
	died.connect(parent._die)
	print(collision_layer)
	print(collision_mask)
func take_hit(hit_source:Node3D, damage:float)->void:
	hp_component.take_damage(damage)
	hit_taken.emit(hit_source)
func _on_hp_updated(hp:HPComponent):
	if hp._hp <= 0.0:
		died.emit()
