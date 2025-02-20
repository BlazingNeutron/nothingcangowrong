extends Control

signal overlay_animation_complete

@onready var animation_player: AnimationPlayer = $ColorRect/AnimationPlayer

func start_overlay() -> void:
	animation_player.play("tutorial-focus")

func overlay_complete() -> void:
	emit_signal("overlay_animation_complete")
