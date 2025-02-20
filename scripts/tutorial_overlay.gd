extends Control

signal tutorial_overlay_complete

@onready var animation_player: AnimationPlayer = $ColorRect/AnimationPlayer

func start_overlay() -> void:
	animation_player.play("tutorial-focus")

func overlay_complete() -> void:
	emit_signal("tutorial_overlay_complete")

func _on_color_rect_gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		overlay_complete()
