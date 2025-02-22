extends "res://scripts/panel.gd"

@onready var top_shield: Sprite2D = $Shields/TopShield
@onready var right_shield: Sprite2D = $Shields/RightShield
@onready var left_shield: Sprite2D = $Shields/LeftShield
@onready var bottom_shield: Sprite2D = $Shields/BottomShield

var top = 0
var left = 0
var right = 0
var bottom = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#Ship.shields_energy_changed.connect(_on_shield_energy_changed)
	pass

func _on_top_shield_restore_button_pressed() -> void:
	if Ship.shields_energy < 5:
		Ship.shields_energy = Ship.shields_energy
		return
	if top == 100:
		return
	top = clamp(top + 20, 0, 100)
	top_shield.modulate.a = clamp(0.3 + (top * 0.007), 0.3, 1.0)
	Ship.shields_energy -= 5

func _on_right_shield_restore_button_pressed() -> void:
	if Ship.shields_energy < 5:
		Ship.shields_energy = Ship.shields_energy
		return
	if right == 100:
		return
	right = clamp(right + 20, 0, 100)
	right_shield.modulate.a = clamp(0.3 + (right * 0.007), 0.3, 1.0)
	Ship.shields_energy -= 5

func _on_bottom_shield_restore_button_pressed() -> void:
	if Ship.shields_energy < 5:
		Ship.shields_energy = Ship.shields_energy
		return
	if bottom == 100:
		return
	bottom = clamp(bottom + 20, 0, 100)
	bottom_shield.modulate.a = clamp(0.3 + (bottom * 0.007), 0.3, 1.0)
	Ship.shields_energy -= 5

func _on_left_shield_restore_button_pressed() -> void:
	if Ship.shields_energy < 5:
		Ship.shields_energy = Ship.shields_energy
		return
	if left == 100:
		return
	left = clamp(left + 20, 0, 100)
	left_shield.modulate.a = clamp(0.3 + (left * 0.007), 0.3, 1.0)
	Ship.shields_energy -= 5
