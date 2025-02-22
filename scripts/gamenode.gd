extends Node2D

@onready var tutorial_overlay: Control = $TutorialOverlay
@onready var wormhole_overlay: Control = $WormholeOverlay
@onready var story: Node2D = $Story

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#story.connect("tutorial_overlay_start", _on_tutorial_overlay_start)
	Game.wormhole_start.connect(_on_wormhole_start)
	Game.tutorial_overlay_start.connect(_on_tutorial_overlay_start)
	Game.tutorial_overlay_complete.connect(_on_tutorial_overlay_complete)
	Game.game_over.connect(_on_game_over)
	Game.start_story()

func _on_tutorial_overlay_start() -> void:
	tutorial_overlay.show()
	get_tree().paused = true

func _on_wormhole_start() -> void:
	wormhole_overlay.show()
	wormhole_overlay.start_wormhole_overlay()

func _on_tutorial_overlay_complete() -> void:
	tutorial_overlay.hide()
	get_tree().paused = false

func _on_game_over() -> void:
	get_tree().change_scene_to_file("res://scenes/GameOverExplosion.tscn")
