extends Node2D

@onready var value_sprite: Sprite2D = $ValueMask/ValueSprite

func _ready() -> void:
	_on_change(_read_value())

func _read_value() -> int:
	return 0

func _on_change(value) -> void:
	value_sprite.position.y = -2 * value
