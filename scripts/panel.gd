extends Node2D

#const SMALL = [0, 175] #starting y & height
#const MEDIUM = [190, 297]
#const LARGE = [496, 496]

func _on_texture_button_pressed() -> void:
	Ship.sensors_energy += 10

func _on_weapon_adder_pressed() -> void:
	Ship.weapons_energy += 10

func _on_life_support_adder_pressed() -> void:
	Ship.life_support_energy += 10

func _on_engine_adder_pressed() -> void:
	Ship.engines_energy += 10

func _on_shields_adder_pressed() -> void:
	Ship.shields_energy += 10
