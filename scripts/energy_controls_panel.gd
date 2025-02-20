extends "res://scripts/panel.gd"

@onready var sensors_v_slider: VSlider = $Control/SensorsVSlider
@onready var weapons_v_slider: VSlider = $Control/WeaponsVSlider
@onready var shields_v_slider: VSlider = $Control/ShieldsVSlider
@onready var engine_v_slider: VSlider = $Control/EngineVSlider
@onready var life_support_v_slider: VSlider = $Control/LifeSupportVSlider

func _on_sensors_v_slider_drag_ended(value_changed: bool) -> void:
	if value_changed:
		Ship.sensors_energy = sensors_v_slider.value
	
func _on_weapons_v_slider_drag_ended(value_changed: bool) -> void:
	if value_changed:
		Ship.weapons_energy = weapons_v_slider.value

func _on_shields_v_slider_drag_ended(value_changed: bool) -> void:
	if value_changed:
		Ship.shields_energy = shields_v_slider.value

func _on_engine_v_slider_drag_ended(value_changed: bool) -> void:
	if value_changed:
		Ship.engines_energy = engine_v_slider.value


func _on_life_support_v_slider_drag_ended(value_changed: bool) -> void:
	if value_changed:
		Ship.life_support_energy = life_support_v_slider.value
