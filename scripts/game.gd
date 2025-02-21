extends Node2D

signal tutorial_overlay_start
signal wormhole_start
signal sensor_sweep_start
signal core_destabilization_started

func fire_event(event_name : String) -> void:
	emit_signal(event_name)

func start_tutorial_overlay() -> void:
	emit_signal("tutorial_overlay_start")
