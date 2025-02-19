extends Node

@onready var value_sprite: Sprite2D = $ValueMask/ValueSprite

func _ready() -> void:
	Ship.core_energy_changed.connect(_on_core_energy_changed)
	_on_core_energy_changed()

func _on_core_energy_changed() -> void:
	var percent_energy = Ship.core_energy
	var radial_angle = (percent_energy/100.0) * 180.0
	value_sprite.rotation_degrees = radial_angle
