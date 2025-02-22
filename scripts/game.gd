extends Node2D

signal story_start
signal tutorial_overlay_start
signal tutorial_overlay_complete
signal tutorial_power_start
signal tutorial_sensors_start
signal tutorial_core_start
signal wormhole_start
signal sensor_sweep_start
signal sensor_sweep_complete
signal sensor_sweep2_start
signal core_destabilization_started
signal core_stabilization_complete
signal chat_message(color, sender_name, message)

var index = 0
var game_story = null

func fire_event(event_name : String) -> void:
	emit_signal(event_name)

func start_story() -> void:
	emit_signal("story_start")

func receive_chat_message(color, sender_name, message) -> void:
	emit_signal("chat_message", color, sender_name, message)

func first_sensor_sweep_complete() -> void:
	emit_signal("sensor_sweep_complete")

func core_stabilized() -> void:
	emit_signal("core_stabilization_complete")

func start_core_destabilization() -> void:
	emit_signal("core_destabilization_started")
