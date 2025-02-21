extends Node2D

@onready var tutorial_overlay: Control = $TutorialOverlay
@onready var wormhole_overlay: Control = $WormholeOverlay
@onready var story: Node2D = $Story

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#story.connect("tutorial_overlay_start", _on_tutorial_overlay_start)
	Game.connect("wormhole_start", _on_wormhole_start)
	tutorial_overlay.hide()
	tutorial_overlay.connect("tutorial_overlay_complete", _on_tutorial_overlay_complete)
	Game.start_story()

func _on_tutorial_overlay_start() -> void:
	tutorial_overlay.show()
	tutorial_overlay.start_overlay()
	get_tree().paused = true

func _on_wormhole_start() -> void:
	wormhole_overlay.show()
	wormhole_overlay.start_wormhole_overlay()

func _on_tutorial_overlay_complete() -> void:
	tutorial_overlay.hide()
	get_tree().paused = false
