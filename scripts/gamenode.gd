extends Node2D

@onready var overlay: Control = $Overlay

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Game.connect("overlay_start", _on_overlay_start)
	overlay.connect("overlay_animation_complete", _on_overlay_complete)

func _on_overlay_start() -> void:
	overlay.show()
	overlay.start_overlay()
	get_tree().paused = true

func _on_overlay_complete() -> void:
	overlay.hide()
	get_tree().paused = false
