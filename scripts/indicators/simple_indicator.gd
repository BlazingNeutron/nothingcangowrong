extends Node2D

@onready var timer: Timer = $Timer
@onready var value_sprite: Sprite2D = $ValueMask/ValueSprite
@onready var system_drained_player: AudioStreamPlayer = $SystemDrainedPlayer
@onready var glow: Sprite2D = %Glow

var unmute = false

func _ready() -> void:
	_on_change(_read_value())

func _read_value() -> int:
	return 0

func _update_display(value) -> void:
	value_sprite.position.y = -2 * value

func _pulse_animation() -> void:
	var tween = create_tween()
	tween.tween_property(glow.material, "shader_parameter/bness", 0.4, 0.2)
	tween.tween_property(glow.material, "shader_parameter/bness", 0.0, 0.2)
	tween.tween_property(glow.material, "shader_parameter/bness", 0.4, 0.2)
	tween.tween_property(glow.material, "shader_parameter/bness", 0.0, 0.2)

func _on_change(value) -> void:
	if value <= 0 and unmute:
		system_drained_player.play()
	_update_display(value)
	_pulse_animation()

func _on_startup_timer_timeout() -> void:
	unmute = true

func _on_timer_timeout() -> void:
	pass # Replace with function body.
