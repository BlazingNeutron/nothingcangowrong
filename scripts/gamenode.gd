extends Node2D

@onready var tutorial_overlay: Control = $TutorialOverlay

@onready var wormhole_overlay: Control = $WormholeOverlay

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Game.connect("overlay_start", _on_overlay_start)
	Game.connect("wormhole_start", _on_wormhole_start)
	tutorial_overlay.hide()
	wormhole_overlay.hide()
	tutorial_overlay.connect("overlay_animation_complete", _on_overlay_complete)
	wormhole_overlay.connect("wormhole_overlay_complete", _on_wormhole_complete)

func _on_overlay_start() -> void:
	tutorial_overlay.show()
	tutorial_overlay.start_overlay()
	get_tree().paused = true

func _on_wormhole_start() -> void:
	wormhole_overlay.show()
	wormhole_overlay.start_wormhole_overlay()

func _on_overlay_complete() -> void:
	tutorial_overlay.hide()
	get_tree().paused = false

func _on_wormhole_complete() -> void:
	wormhole_overlay.hide()
