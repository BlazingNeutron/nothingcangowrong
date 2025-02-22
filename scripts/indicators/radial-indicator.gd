extends Node

@onready var value_sprite: Sprite2D = $ValueMask/ValueSprite
@onready var animation_player: AnimationPlayer = $WarningIcon/AnimationPlayer
@onready var core_status_timer: Timer = $CoreStatusTimer

var dangerzone = 0
var message_sent = false

func _ready() -> void:
	Ship.core_energy_changed.connect(_on_core_energy_changed)
	Game.connect("core_energy_warning", _on_core_energy_warning)
	update_core_energy()

func _pulse_animation() -> void:
	var glow = get_node("%Glow")
	var tween = create_tween()
	tween.tween_property(glow.material, "shader_parameter/bness", 0.4, 0.2)
	tween.tween_property(glow.material, "shader_parameter/bness", 0.0, 0.2)
	tween.tween_property(glow.material, "shader_parameter/bness", 0.4, 0.2)
	tween.tween_property(glow.material, "shader_parameter/bness", 0.0, 0.2)

func update_core_energy() -> void:
	animation_player.play("RESET")
	var percent_energy = Ship.core_energy
	var radial_angle = (percent_energy/100.0) * 180.0
	value_sprite.rotation_degrees = radial_angle

func _on_core_energy_changed() -> void:
	update_core_energy()
	_pulse_animation()

func _on_core_energy_warning() -> void:
	animation_player.play("warning_flash")

func _on_timer_timeout() -> void:
	if Ship.core_energy <= 5:
		_on_core_energy_changed()
		dangerzone += 1
		if dangerzone >= 3 and not message_sent:
			Game.fire_event("core_energy_warning")
			message_sent = true
		elif dangerzone == 10:
			Game.fire_event("game_over")
	else:
		message_sent = false
		dangerzone = 0
