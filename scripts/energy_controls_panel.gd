extends "res://scripts/panel.gd"

@onready var sensors_v_slider: VSlider = $Control/SensorsVSlider
@onready var weapons_v_slider: VSlider = $Control/WeaponsVSlider
@onready var shields_v_slider: VSlider = $Control/ShieldsVSlider
@onready var engine_v_slider: VSlider = $Control/EngineVSlider
@onready var life_support_v_slider: VSlider = $Control/LifeSupportVSlider

func _ready() -> void:
	Ship.connect("sensors_energy_changed", on_sensors_energy_changed)
	on_sensors_energy_changed()
	Ship.connect("weapons_energy_changed", on_weapons_energy_changed)
	on_weapons_energy_changed()
	Ship.connect("shields_energy_changed", on_shields_energy_changed)
	on_shields_energy_changed()
	Ship.connect("engines_energy_changed", on_engines_energy_changed)
	on_engines_energy_changed()
	Ship.connect("lifesupport_energy_changed", on_life_support_energy_changed)
	on_life_support_energy_changed()

func on_sensors_energy_changed() -> void:
	sensors_v_slider.value = Ship.sensors_energy

func on_weapons_energy_changed() -> void:
	weapons_v_slider.value = Ship.weapons_energy

func on_shields_energy_changed() -> void:
	shields_v_slider.value = Ship.shields_energy

func on_engines_energy_changed() -> void:
	engine_v_slider.value = Ship.engines_energy

func on_life_support_energy_changed() -> void:
	life_support_v_slider.value = Ship.life_support_energy

func _on_sensors_v_slider_drag_ended(value_changed: bool) -> void:
	if value_changed:
		if Ship.sensors_energy > sensors_v_slider.value:
			Ship.core_drain += Ship.sensors_energy - sensors_v_slider.value
		Ship.sensors_energy = sensors_v_slider.value

func _on_weapons_v_slider_drag_ended(value_changed: bool) -> void:
	if value_changed:
		if Ship.weapons_energy > weapons_v_slider.value:
			Ship.core_drain += Ship.weapons_energy - weapons_v_slider.value
		Ship.weapons_energy = weapons_v_slider.value

func _on_shields_v_slider_drag_ended(value_changed: bool) -> void:
	if value_changed:
		if Ship.shields_energy > shields_v_slider.value:
			Ship.core_drain += Ship.shields_energy - shields_v_slider.value
		Ship.shields_energy = shields_v_slider.value

func _on_engine_v_slider_drag_ended(value_changed: bool) -> void:
	if value_changed:
		if Ship.engines_energy > engine_v_slider.value:
			Ship.core_drain += Ship.engines_energy - engine_v_slider.value
		Ship.engines_energy = engine_v_slider.value

func _on_life_support_v_slider_drag_ended(value_changed: bool) -> void:
	if value_changed:
		if Ship.life_support_energy > life_support_v_slider.value:
			Ship.core_drain += Ship.life_support_energy - life_support_v_slider.value
		Ship.life_support_energy = life_support_v_slider.value
