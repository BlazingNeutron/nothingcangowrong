extends Node2D

@onready var value_sprite: Sprite2D = $ValueMask/ValueSprite

func _ready() -> void:
	Ship.sensors_energy_changed.connect(_on_sensor_energy_changed)
	_on_sensor_energy_changed()

func _on_sensor_energy_changed() -> void:
	var percent_energy = Ship.sensors_energy
	value_sprite.position.y = -2 * percent_energy
