extends Node2D
@onready var control: Control = $Control
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var timer: Timer = $Timer
@onready var explosion_sounds: AudioStreamPlayer = $ExplosionSounds

func _ready() -> void:
	control.hide()

func _on_animated_sprite_2d_animation_finished() -> void:
	control.show()

func _on_restart_button_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/Game.tscn")

func _on_main_menu_button_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/MainMenu.tscn")

func _on_timer_timeout() -> void:
	animated_sprite_2d.play()
	explosion_sounds.play()
