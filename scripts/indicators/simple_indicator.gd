extends Node2D

@onready var value_sprite: Sprite2D = $ValueMask/ValueSprite

func _ready() -> void:
	_on_change(_read_value())

func _read_value() -> int:
	return 0

func _update_display(value) -> void:
	value_sprite.position.y = -2 * value

func _pulse_animation() -> void:
	var glow = get_node("%Glow")
	var tween = create_tween()
	tween.tween_property(glow.material, "shader_parameter/bness", 0.4, 0.2)
	tween.tween_property(glow.material, "shader_parameter/bness", 0.0, 0.2)
	tween.tween_property(glow.material, "shader_parameter/bness", 0.4, 0.2)
	tween.tween_property(glow.material, "shader_parameter/bness", 0.0, 0.2)

func _on_change(value) -> void:
	_update_display(value)
	_pulse_animation()
