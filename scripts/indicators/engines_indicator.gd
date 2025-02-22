extends "res://scripts/indicators/simple_indicator.gd"

var dangerzone = 0
var wormhole_event_started = false

func _ready() -> void:
	Game.connect("wormhole_start", _on_wormhole_start)
	Game.connect("core_stabilization_complete", _on_wormhole_complete)
	Ship.engines_energy_changed.connect(_on_engines_energy_changed)
	self._update_display(Ship.engines_energy)

func _read_value() -> int:
	return Ship.engines_energy

func _on_engines_energy_changed() -> void:
	_on_change(Ship.engines_energy)

func _on_wormhole_start() -> void:
	wormhole_event_started = true

func _on_wormhole_complete() -> void:
	wormhole_event_started = false

func _on_timer_timeout() -> void:
	if Ship.engines_energy <= 5 and wormhole_event_started:
		_on_change(Ship.engines_energy)
		dangerzone += 1
		if dangerzone == 3:
			Game.fire_event("engine_warning")
		elif dangerzone == 7:
			Game.fire_event("game_over")
	else:
		dangerzone = 0
