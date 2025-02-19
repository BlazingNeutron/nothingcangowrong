extends Node

signal core_energy_changed
signal weapons_energy_changed
signal shields_energy_changed
signal engines_energy_changed
signal sensors_energy_changed
signal lifesupport_energy_changed

var core_energy : int = 100 : 
	get: 
		return core_energy
	set(value):
		core_energy = clamp(value, 0, 100)
		emit_signal("core_energy_changed")
var weapons_energy : int = 0 :
	get: 
		return weapons_energy
	set(value):
		weapons_energy = clamp(value, 0, 100)
		emit_signal("weapons_energy_changed")
		recalc_core()
var shields_energy : int = 0 :
	get: 
		return shields_energy
	set(value):
		shields_energy = clamp(value, 0, 100)
		emit_signal("shields_energy_changed")
		recalc_core()
var engines_energy : int = 0 :
	get: 
		return engines_energy
	set(value):
		engines_energy = clamp(value, 0, 100)
		emit_signal("engines_energy_changed")
		recalc_core()
var sensors_energy : int = 0 :
	get: 
		return sensors_energy
	set(value):
		sensors_energy = clamp(value, 0, 100)
		emit_signal("sensors_energy_changed")
		recalc_core()

var life_support_energy : int = 0 :
	get: 
		return life_support_energy
	set(value):
		life_support_energy = clamp(value, 0, 100)
		emit_signal("life_support_energy_changed")
		recalc_core()

func _ready() -> void:
	emit_signal("sensors_energy_changed")
	emit_signal("core_energy_changed")
	emit_signal("weapons_energy_changed")
	emit_signal("shields_energy_changed")
	emit_signal("engines_energy_changed")
	emit_signal("life_support_energy_changed")
	recalc_core()

func recalc_core() -> void:
	core_energy = 100 - sensors_energy - weapons_energy - shields_energy - engines_energy - life_support_energy
