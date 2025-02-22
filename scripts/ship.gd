extends Node

signal core_energy_changed
signal weapons_energy_changed
signal shields_energy_changed
signal engines_energy_changed
signal sensors_energy_changed
signal lifesupport_energy_changed

var core_drain : int = 0 : 
	get: 
		return core_drain
	set(value):
		core_drain = value
		recalc_core()
		core_energy_changed.emit()
var core_energy : int = 100 : 
	get: 
		return core_energy
	set(value):
		core_energy = ratiod_core_energy()
		core_energy_changed.emit()
var weapons_energy : int = 0 :
	get: 
		return weapons_energy
	set(value):
		weapons_energy = clamp(value, 0, 100)
		weapons_energy_changed.emit()
		recalc_core()
var shields_energy : int = 10 :
	get: 
		return shields_energy
	set(value):
		shields_energy = clamp(value, 0, 100)
		shields_energy_changed.emit()
		recalc_core()
var engines_energy : int = 40 :
	get: 
		return engines_energy
	set(value):
		engines_energy = clamp(value, 0, 100)
		engines_energy_changed.emit()
		recalc_core()
var sensors_energy : int = 10 :
	get: 
		return sensors_energy
	set(value):
		sensors_energy = clamp(value, 0, 100)
		sensors_energy_changed.emit()
		recalc_core()
var life_support_energy : int = 10 :
	get: 
		return life_support_energy
	set(value):
		life_support_energy = clamp(value, 0, 100)
		lifesupport_energy_changed.emit()
		recalc_core()
var core_warning = false
var timer : Timer = null

func _ready() -> void:
	sensors_energy_changed.emit()
	core_energy_changed.emit()
	weapons_energy_changed.emit()
	shields_energy_changed.emit()
	engines_energy_changed.emit()
	lifesupport_energy_changed.emit()
	Game.story_start.connect(restart_game)
	Game.core_energy_drain.connect(energy_drain)
	recalc_core()

func ratiod_core_energy() -> int:
	return 100 - core_drain - (sensors_energy/2) - (weapons_energy/3) - shields_energy - (engines_energy/2) - (life_support_energy/10)

func recalc_core() -> void:
	core_energy = ratiod_core_energy()
	if core_warning and core_energy > 5:
		core_warning = false
	if core_energy <= 5:
		core_warning = true
		Game.core_energy_warning.emit()

func energy_drain() -> void:
	sensors_energy -= 10
	weapons_energy -= 10
	shields_energy -= 10
	engines_energy -= 10
	life_support_energy -= 5
	core_drain += 25

func energy_restored() -> void:
	recalc_core()

func restart_game() -> void:
	weapons_energy = 0
	shields_energy = 10
	engines_energy = 40
	sensors_energy = 10
	life_support_energy = 10
	core_drain = 0
	recalc_core()
