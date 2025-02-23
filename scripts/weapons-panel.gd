extends "res://scripts/panel.gd"

@onready var toggle_button: TextureButton = $WeaponsSystems/ToggleButton
@onready var weapon_fill: Sprite2D = $WeaponsSystems/WeaponOutline/Node2D/WeaponFill
@onready var weapons_fire_sound: AudioStreamPlayer = $WeaponsFireSound
@onready var energy_fill_sound: AudioStreamPlayer = $EnergyFillSound
@onready var toggle_switch_sound: AudioStreamPlayer = $ToggleSwitchSound
@onready var weapons_firing_timer: Timer = $WeaponsFiringTimer
@onready var weapons_fill_timer: Timer = $WeaponsFillTimer

func _ready() -> void:
	randomize()
	Game.alien_fight_start.connect(_on_alien_fight_start)
	Game.alien_fight_completed.connect(_on_alien_fight_completed)

func _on_alien_fight_start() -> void:
	weapons_firing_timer.wait_time = 4
	weapons_firing_timer.start()

func _on_alien_fight_completed() -> void:
	weapons_firing_timer.stop()

func _on_toggle_button_pressed() -> void:
	if toggle_button.button_pressed:
		weapons_fill_timer.start()
	else:
		weapons_fill_timer.stop()

func _on_weapons_fill_timer_timeout() -> void:
	if Ship.weapons_energy > 0 and toggle_button.button_pressed and weapon_fill.position.y > -1700:
		var newPosY = clamp(weapon_fill.position.y - 20, -1700, 0)
		weapon_fill.position.y = newPosY
		Ship.weapons_energy -= 1
	else:
		toggle_button.button_pressed = false
		weapons_fill_timer.stop()

func _on_weapons_firing_timer_timeout() -> void:
	weapons_firing_timer.wait_time = randf_range(2.0, 5.0)
	if weapon_fill.position.y > -1700:
		var newPosY = clamp(weapon_fill.position.y + 100, -1700, 0)
		weapon_fill.position.y = newPosY
