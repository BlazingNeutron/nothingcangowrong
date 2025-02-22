extends Node2D

signal story_start
signal tutorial_overlay_start
signal tutorial_overlay_complete
signal tutorial_power_start
signal tutorial_sensors_start
signal tutorial_core_start
signal tutorial_shields_start
signal wormhole_start
signal sensor_sweep_start
signal sensor_sweep_complete
signal sensor_sweep2_start
signal sensor_sweep2_complete
signal core_destabilization_started
signal core_stabilization_complete
signal chat_message(color, sender_name, message)
signal life_support_warning
signal game_over
signal engine_warning
signal core_energy_warning
signal core_energy_drain
signal alien_fight_start
signal alien_fight_completed

var index = 0
var game_story = null

func fire_event(event_name : String) -> void:
	emit_signal(event_name)

func start_story() -> void:
	story_start.emit()

func receive_chat_message(color, sender_name, message) -> void:
	chat_message.emit(color, sender_name, message)

func first_sensor_sweep_complete() -> void:
	sensor_sweep_complete.emit()

func second_sensor_sweep_complete() -> void:
	sensor_sweep2_complete.emit()

func core_stabilized() -> void:
	core_stabilization_complete.emit()

func start_core_destabilization() -> void:
	core_destabilization_started.emit()

func life_support_warnings() -> void:
	life_support_warning.emit()

func life_support_death() -> void:
	game_over.emit()
