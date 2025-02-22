extends "res://scripts/panel.gd"

@onready var toggle_button: TextureButton = $WeaponsSystems/ToggleButton
@onready var weapon_fill: Sprite2D = $WeaponsSystems/WeaponOutline/WeaponFill
@onready var weapons_fire_sound: AudioStreamPlayer = $WeaponsFireSound
@onready var energy_fill_sound: AudioStreamPlayer = $EnergyFillSound
@onready var toggle_switch_sound: AudioStreamPlayer = $ToggleSwitchSound
@onready var weapons_firing_timer: Timer = $WeaponsFiringTimer
@onready var weapons_fill_timer: Timer = $WeaponsFillTimer

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_toggle_button_pressed() -> void:
	pass
