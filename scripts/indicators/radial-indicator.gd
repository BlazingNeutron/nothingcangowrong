extends Node

@onready var value_sprite: Sprite2D = $ValueMask/ValueSprite
@onready var core_status_timer: Timer = $CoreStatusTimer
@onready var core_drain_restore_timer: Timer = $CoreDrainRestoreTimer
@onready var warning_icon: Sprite2D = $WarningIcon
@onready var animation_player: AnimationPlayer = $WarningIcon/AnimationPlayer
@onready var core_critical_player: AudioStreamPlayer = $CoreCriticalPlayer

var dangerzone = 0
var message_sent = false

func _ready() -> void:
	Ship.core_energy_changed.connect(_on_core_energy_changed)
	Game.core_energy_warning.connect(_on_core_energy_warning)
	update_core_energy()
	animation_player.play("warning_flash")

func _pulse_animation() -> void:
	var glow = get_node("%Glow")
	var tween = create_tween()
	tween.tween_property(glow.material, "shader_parameter/bness", 0.4, 0.2)
	tween.tween_property(glow.material, "shader_parameter/bness", 0.0, 0.2)
	tween.tween_property(glow.material, "shader_parameter/bness", 0.4, 0.2)
	tween.tween_property(glow.material, "shader_parameter/bness", 0.0, 0.2)

func update_core_energy() -> void:
	if Ship.core_energy > 5:
		warning_icon.hide()
	var percent_energy = Ship.core_energy
	var radial_angle = (percent_energy/100.0) * 180.0
	value_sprite.rotation_degrees = clamp(radial_angle, 0, 180)

func _on_core_energy_changed() -> void:
	update_core_energy()
	_pulse_animation()

func _on_core_energy_warning() -> void:
	warning_icon.show()
	core_critical_player.play()

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

func _on_core_drain_restore_timer_timeout() -> void:
	if Ship.core_drain > 0:
		Ship.core_drain -= 5
