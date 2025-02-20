extends "res://scripts/indicators/simple_indicator.gd"

func _ready() -> void:
	Ship.engines_energy_changed.connect(_on_engines_energy_changed)
	self._update_display(Ship.engines_energy)

func _read_value() -> int:
	return Ship.engines_energy

func _on_engines_energy_changed() -> void:
	_on_change(Ship.engines_energy)
