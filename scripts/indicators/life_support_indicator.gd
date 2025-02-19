extends "res://scripts/indicators/simple_indicator.gd"

func _ready() -> void:
	Ship.lifesupport_energy_changed.connect(_on_lifesupport_energy_changed)

func _read_value() -> int:
	return Ship.life_support_energy

func _on_lifesupport_energy_changed() -> void:
	_on_change(Ship.life_support_energy)
