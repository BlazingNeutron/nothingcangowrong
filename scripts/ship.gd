extends Node

signal core_energy_changed
signal weapon_energy_changed
signal shields_energy_changed
signal engines_energy_changed
signal sensors_energy_changed
signal lifesupport_energy_changed

var core_energy : int = 95 : 
	get: 
		return core_energy
	set(value):
		core_energy = clamp(value, 0, 100)
		emit_signal("core_energy_changed")

var weapons_energy = 0
var shields_energy = 0
var engines_energy = 0
var sensors_energy : int = 0 :
	get: 
		return sensors_energy
	set(value):
		sensors_energy = clamp(value, 0, 100)
		emit_signal("sensors_energy_changed")
		recalc_core()

var life_support_energy = 0

func _ready() -> void:
	emit_signal("sensors_energy_changed")
	emit_signal("core_energy_changed")
	recalc_core()

func recalc_core() -> void:
	core_energy = 100 - sensors_energy
