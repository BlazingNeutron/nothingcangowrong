extends "res://scripts/indicators/simple_indicator.gd"

func _ready() -> void:
	Ship.sensors_energy_changed.connect(_on_sensor_energy_changed)
	self._update_display(Ship.sensors_energy)

func _read_value() -> int:
	return Ship.sensors_energy

func _on_sensor_energy_changed() -> void:
	_on_change(Ship.sensors_energy)
