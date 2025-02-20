extends "res://scripts/indicators/simple_indicator.gd"

func _ready() -> void:
	Ship.shields_energy_changed.connect(_on_shields_energy_changed)
	_on_shields_energy_changed()

func _read_value() -> int:
	return Ship.shields_energy

func _on_shields_energy_changed() -> void:
	_on_change(Ship.shields_energy)
