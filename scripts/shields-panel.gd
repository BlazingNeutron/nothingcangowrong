extends "res://scripts/panel.gd"

@onready var top_shield: Sprite2D = $Shields/TopShield
@onready var right_shield: Sprite2D = $Shields/RightShield
@onready var bottom_shield: Sprite2D = $Shields/BottomShield
@onready var left_shield: Sprite2D = $Shields/LeftShield

@onready var alien_fight_timer: Timer = $AlienFightTimer
@onready var alien_shots_fired_timer: Timer = $AlienShotsFiredTimer

var top = 25
var right = 25
var bottom = 25
var left = 25
var alien_fight_started = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	randomize()
	top = 50
	right = 0
	bottom = 25
	left = 0
	Game.alien_fight_start.connect(_on_alien_fight_start)
	Game.alien_fight_completed.connect(_on_alien_fight_completed)
	update_shields()

func update_shields() -> void:
	update_top_shield()
	update_right_shield()
	update_bottom_shield()
	update_left_shield()

func update_top_shield() -> void:
	top_shield.modulate.a = clamp(0.3 + (top * 0.007), 0.3, 1.0)

func update_right_shield() -> void:
	right_shield.modulate.a = clamp(0.3 + (right * 0.007), 0.3, 1.0)

func update_bottom_shield() -> void:
	bottom_shield.modulate.a = clamp(0.3 + (bottom * 0.007), 0.3, 1.0)

func update_left_shield() -> void:
	left_shield.modulate.a = clamp(0.3 + (left * 0.007), 0.3, 1.0)

func _on_top_shield_restore_button_pressed() -> void:
	if Ship.shields_energy < 5:
		Ship.shields_energy = Ship.shields_energy
		return
	if top == 100:
		return
	top = clamp(top + 20, 0, 100)
	update_top_shield()
	Ship.shields_energy -= 5

func _on_right_shield_restore_button_pressed() -> void:
	if Ship.shields_energy < 5:
		Ship.shields_energy = Ship.shields_energy
		return
	if right == 100:
		return
	right = clamp(right + 20, 0, 100)
	update_right_shield()
	Ship.shields_energy -= 5

func _on_bottom_shield_restore_button_pressed() -> void:
	if Ship.shields_energy < 5:
		Ship.shields_energy = Ship.shields_energy
		return
	if bottom == 100:
		return
	bottom = clamp(bottom + 20, 0, 100)
	update_bottom_shield()
	Ship.shields_energy -= 5

func _on_left_shield_restore_button_pressed() -> void:
	if Ship.shields_energy < 5:
		Ship.shields_energy = Ship.shields_energy
		return
	if left == 100:
		return
	left = clamp(left + 20, 0, 100)
	update_left_shield()
	Ship.shields_energy -= 5

func _on_alien_fight_start() -> void:
	alien_fight_started = true
	alien_shots_fired_timer.start()

func _on_alien_fight_completed() -> void:
	alien_fight_started = false
	alien_shots_fired_timer.stop()

func _on_alien_fight_timer_timeout() -> void:
	Game.alien_fight_completed.emit()

func _on_alien_shots_fired_timer_timeout() -> void:
	var direction = randi_range(0, 4)
	var damage = randi_range(1, 3)
	if direction == 1:
		if top <= 0:
			Game.game_over.emit()
			return
		top -= 10 * damage
		update_top_shield()
	elif direction == 2:
		if right <= 0:
			Game.game_over.emit()
			return
		right -= 10 * damage
		update_right_shield()
	elif direction == 3:
		if bottom <= 0:
			Game.game_over.emit()
			return
		bottom -= 10 * damage
		update_bottom_shield()
	elif direction == 4:
		if left <= 0:
			Game.game_over.emit()
			return
		left -= 10 * damage
		update_left_shield()
	alien_shots_fired_timer.wait_time = randf_range(0.2, 3.0)
	alien_shots_fired_timer.start()
