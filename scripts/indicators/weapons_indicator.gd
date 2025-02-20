extends "res://scripts/indicators/simple_indicator.gd"

func _ready() -> void:
	Ship.weapons_energy_changed.connect(_on_weapons_energy_changed)
	_on_weapons_energy_changed()

func _read_value() -> int:
	return Ship.weapons_energy

func _on_weapons_energy_changed() -> void:
	_on_change(Ship.weapons_energy)
