extends "res://scripts/panel.gd"

@onready var life_support_sound: AudioStreamPlayer = $LifeSupportSound

func _ready() -> void:
	Game.life_support_warning.connect(_on_life_support_warning)

func _on_life_support_warning() -> void:
	life_support_sound.play()
