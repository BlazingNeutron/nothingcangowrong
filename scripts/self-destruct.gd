extends "res://scripts/panel.gd"

func _on_texture_button_pressed() -> void:
	Game.game_over.emit()
