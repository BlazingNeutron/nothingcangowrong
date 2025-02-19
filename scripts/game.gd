extends Node2D

signal overlay_start

func start_overlay() -> void:
	emit_signal("overlay_start")
