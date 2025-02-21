extends Node

signal core_energy_changed
signal core_energy_warning
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
var shields_energy : int = 10 :
	get: 
		return shields_energy
	set(value):
		shields_energy = clamp(value, 0, 100)
		emit_signal("shields_energy_changed")
		recalc_core()
var engines_energy : int = 40 :
	get: 
		return engines_energy
	set(value):
		engines_energy = clamp(value, 0, 100)
		emit_signal("engines_energy_changed")
		recalc_core()
var sensors_energy : int = 10 :
	get: 
		return sensors_energy
	set(value):
		sensors_energy = clamp(value, 0, 100)
		emit_signal("sensors_energy_changed")
		recalc_core()
var life_support_energy : int = 10 :
	get: 
		return life_support_energy
	set(value):
		life_support_energy = clamp(value, 0, 100)
		emit_signal("lifesupport_energy_changed")
		recalc_core()
var core_warning = false
var timer : Timer = null

func _ready() -> void:
	emit_signal("sensors_energy_changed")
	emit_signal("core_energy_changed")
	emit_signal("weapons_energy_changed")
	emit_signal("shields_energy_changed")
	emit_signal("engines_energy_changed")
	emit_signal("lifesupport_energy_changed")
	recalc_core()

func recalc_core() -> void:
	core_energy = 100 - (sensors_energy/2) - (weapons_energy/3) - shields_energy - (engines_energy/2) - (life_support_energy/10)
	if core_warning and core_energy > 0:
		core_warning = false
	if core_energy <= 0:
		core_warning = true
		emit_signal("core_energy_warning")

func energy_drain() -> void:
	#var old_core_energy = core_energy
	sensors_energy -= 10
	weapons_energy -= 10
	shields_energy -= 10
	engines_energy -= 10
	life_support_energy -= 5
	core_energy -= 25

func energy_restored() -> void:
	recalc_core()
