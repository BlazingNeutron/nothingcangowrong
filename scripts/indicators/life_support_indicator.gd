extends "res://scripts/indicators/simple_indicator.gd"

var dangerzone = 0

func _ready() -> void:
	Ship.lifesupport_energy_changed.connect(_on_lifesupport_energy_changed)
	self._update_display(Ship.life_support_energy)

func _read_value() -> int:
	return Ship.life_support_energy

func _on_lifesupport_energy_changed() -> void:
	_on_change(Ship.life_support_energy)

func _on_timer_timeout() -> void:
	if Ship.life_support_energy <= 5:
		_on_change(Ship.life_support_energy)
		dangerzone += 1
		if dangerzone == 2:
			Game.life_support_warnings()
		elif dangerzone == 5:
			Game.life_support_death()
	else:
		dangerzone = 0
