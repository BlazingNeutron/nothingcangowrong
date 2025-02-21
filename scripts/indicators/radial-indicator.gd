extends Node

@onready var value_sprite: Sprite2D = $ValueMask/ValueSprite
@onready var animation_player: AnimationPlayer = $Sprite2D/AnimationPlayer

func _ready() -> void:
	Ship.core_energy_changed.connect(_on_core_energy_changed)
	Ship.core_energy_warning.connect(_on_core_energy_warning)
	_on_core_energy_changed()

func _on_core_energy_changed() -> void:
	animation_player.play("RESET")
	var percent_energy = Ship.core_energy
	var radial_angle = (percent_energy/100.0) * 180.0
	value_sprite.rotation_degrees = radial_angle

func _on_core_energy_warning() -> void:
	animation_player.play("warning_flash")
