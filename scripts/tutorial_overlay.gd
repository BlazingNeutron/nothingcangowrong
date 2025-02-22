extends Control

@onready var animation_player: AnimationPlayer = $ColorRect/AnimationPlayer
@onready var tutorial_text_panel: Panel = $Panel
@onready var tutorial_text: RichTextLabel = $Panel/TutorialText

func _ready() -> void:
	Game.tutorial_shields_start.connect(_on_tutorial_shields_start)
	Game.tutorial_power_start.connect(_on_tutorial_power_start)
	Game.tutorial_sensors_start.connect(_on_tutorial_sensors_start)
	Game.tutorial_core_start.connect(_on_tutorial_core_start)

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
	tutorial_text.text = "This is the power core display panel. Wormholes travel causes dark matter ions to radiate from the core. The button will discharge the core, draining power from all of the systems each time, but will get rid of any visible spawned ions. If too many ions are allowed in the core, the core will explode. "
	self.position.x = -900
	self.position.y = 300
	tutorial_text_panel.position.x = 350
	tutorial_text_panel.position.y = -400
	start_overlay()

func _on_tutorial_shields_start() -> void:
	tutorial_text.text = "This is the shields distribution controls. Assign shields to different areas of the ship, don't let an area go weak during a battle."
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
