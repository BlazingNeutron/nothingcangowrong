extends Control

@onready var animation_player: AnimationPlayer = $ColorRect/AnimationPlayer
@onready var tutorial_text_panel: Panel = $Panel
@onready var tutorial_text: RichTextLabel = $Panel/TutorialText

func _ready() -> void:
	Game.connect("tutorial_power_start", _on_tutorial_power_start)
	Game.connect("tutorial_sensors_start", _on_tutorial_sensors_start)
	Game.connect("tutorial_core_start", _on_tutorial_core_start)

func _on_tutorial_power_start() -> void:
	tutorial_text.text = "These are the power level indicators and controls. The indicators are for the core, sensors, weapons, shields, engines and life support. You can adjust power levels as required for your tasks. Don't use all the core's power, it'll overheat."
	self.position.x = -500
	self.position.y = -500
	tutorial_text_panel.position.x = 650
	tutorial_text_panel.position.y = 200
	start_overlay()

func _on_tutorial_sensors_start() -> void:
	tutorial_text.text = "These are the sensors controls. You can locate and scan objects in space! Monitor the sensors power levels."
	self.position.x = -200
	self.position.y = 200
	tutorial_text_panel.position.x = -800
	tutorial_text_panel.position.y = -600
	start_overlay()

func _on_tutorial_core_start() -> void:
	tutorial_text.text = "This is the core level stability scanner and discharge controls. Discharging drains the core and all systems lose energy, but will save you from any negative affects of ionization."
	self.position.x = -900
	self.position.y = 300
	tutorial_text_panel.position.x = 350
	tutorial_text_panel.position.y = -400
	start_overlay()

func start_overlay() -> void:
	animation_player.play("tutorial-focus")

func overlay_complete() -> void:
	Game.fire_event("tutorial_overlay_complete")

func _on_button_pressed() -> void:
	overlay_complete()
