extends "res://scripts/panel.gd"

signal sensor_sweep_complete
signal sensor_item_found

@onready var sensor_object: Sprite2D = $SpaceScreen/SpaceMask/SpaceObjects/SensorObject
@onready var right_arrows: Sprite2D = $SpaceScreen/SpaceMask/Blinkers/RightArrows
@onready var left_arrows: Sprite2D = $SpaceScreen/SpaceMask/Blinkers/LeftArrows
@onready var top_claw: Sprite2D = $SpaceScreen/SpaceMask/Claws/TopClaw
@onready var bottom_claw: Sprite2D = $SpaceScreen/SpaceMask/Claws/BottomClaw
@onready var space: Sprite2D = $SpaceScreen/SpaceMask/SpaceObjects/Space

var next_space_object = 0
var sensor_sweep_started = false
var focus_amount = 10
var objects_found = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	randomize()
	Game.connect("sensor_sweep_start", _on_sensor_sweep_start)

func _on_sensor_sweep_start() -> void:
	sensor_sweep_started = true
	show_next_space_object()

func reset_sensor_view() -> void:
	sensor_object.hide()
	right_arrows.hide()
	left_arrows.hide()
	top_claw.position.y = -155
	bottom_claw.position.y = 155
	focus_amount = 10
	sensor_object.material.set("shader_parameter/amount", focus_amount)

func show_next_space_object() -> void:
	reset_sensor_view()
	var object_to_find = randi_range(1, 2)
	if objects_found >= 4:
		object_to_find = 0
	sensor_object.show()
	sensor_object.region_rect.position.x = 100 * object_to_find
	var direction = randi_range(0, 1)
	next_space_object = direction
	if direction == 1:
		sensor_object.position.x = 250
		right_arrows.show()
	else:
		sensor_object.position.x = -250
		left_arrows.show()

func _on_close_clamp_button_pressed() -> void:
	if Ship.sensors_energy < 10:
		return
	if top_claw.position.y == -105:
		top_claw.position.y = -155
		bottom_claw.position.y = 155
	else:
		top_claw.position.y += 10
		bottom_claw.position.y -= 10
	if sensor_sweep_started and sensor_object.position.x == 0:
		var tween = create_tween()
		focus_amount *= 2
		tween.tween_property(sensor_object.material, "shader_parameter/amount", focus_amount, 0.2)
		if focus_amount > 250:
			objects_found += 1
			tween.tween_property(sensor_object.material, "shader_parameter/amount", 10, 0.1)
			if objects_found < 5:
				reset_sensor_view()
				show_next_space_object()
			elif objects_found == 5:
				Game.first_sensor_sweep_complete()
	Ship.sensors_energy -= 10

func _on_left_button_pressed() -> void:
	if Ship.sensors_energy < 5:
		return
	if sensor_sweep_started:
		sensor_object.position.x += 50
	space.position.x +=10
	if sensor_object.position.x == 0:
		right_arrows.hide()
		left_arrows.hide()
	Ship.sensors_energy -= 5

func _on_right_button_pressed() -> void:
	if Ship.sensors_energy < 5:
		return
	sensor_object.position.x -= 50
	space.position.x -= 10
	if sensor_object.position.x == 0:
		right_arrows.hide()
		left_arrows.hide()
	Ship.sensors_energy -= 5
