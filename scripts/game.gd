extends Node2D

signal tutorial_overlay_start
signal wormhole_start
signal sensor_sweep_start

func start_tutorial_overlay() -> void:
	emit_signal("tutorial_overlay_start")
