extends "res://scripts/panel.gd"

@onready var top_shield: Sprite2D = $Shields/TopShield
@onready var right_shield: Sprite2D = $Shields/RightShield
@onready var bottom_shield: Sprite2D = $Shields/BottomShield
@onready var left_shield: Sprite2D = $Shields/LeftShield

@onready var alien_fight_timer: Timer = $AlienFightTimer
@onready var alien_shots_fired_timer: Timer = $AlienShotsFiredTimer
@onready var shield_up_sound: AudioStreamPlayer = $ShieldUpSound
@onready var shield_damage_sound: AudioStreamPlayer = $ShieldDamageSound

var top = 25
var right = 25
var bottom = 25
var left = 25
var alien_fight_started = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	randomize()
	top = 1
	right = 1
	bottom = 1
	left = 1
	Game.alien_fight_start.connect(_on_alien_fight_start)
	Game.alien_fight_completed.connect(_on_alien_fight_completed)
	update_shields()

func update_shields() -> void:
	update_top_shield()
	update_right_shield()
	update_bottom_shield()
	update_left_shield()

func update_shield(shield : Sprite2D, value : int) -> void:
	if value <= 0:
		shield.modulate.r = 0
		shield.modulate.g = 0
		shield.modulate.b = 0
	else:
		shield.modulate.r = 1
		shield.modulate.g = 1
		shield.modulate.b = 1
	shield.modulate.a = clamp(0.3 + (value * 0.007), 0.3, 1.0)

func update_top_shield() -> void:
	update_shield(top_shield, top)

func update_right_shield() -> void:
	update_shield(right_shield, right)

func update_bottom_shield() -> void:
	update_shield(bottom_shield, bottom)

func update_left_shield() -> void:
	update_shield(left_shield, left)

func _on_top_shield_restore_button_pressed() -> void:
	if Ship.shields_energy < 5:
		Ship.shields_energy = Ship.shields_energy
		return
	if top == 100:
		return
	shield_up_sound.play()
	top = clamp(top + 20, 0, 100)
	update_top_shield()
	Ship.shields_energy -= 5

func _on_right_shield_restore_button_pressed() -> void:
	if Ship.shields_energy < 5:
		Ship.shields_energy = Ship.shields_energy
		return
	if right == 100:
		return
	shield_up_sound.play()
	right = clamp(right + 20, 0, 100)
	update_right_shield()
	Ship.shields_energy -= 5

func _on_bottom_shield_restore_button_pressed() -> void:
	if Ship.shields_energy < 5:
		Ship.shields_energy = Ship.shields_energy
		return
	if bottom == 100:
		return
	shield_up_sound.play()
	bottom = clamp(bottom + 20, 0, 100)
	update_bottom_shield()
	Ship.shields_energy -= 5

func _on_left_shield_restore_button_pressed() -> void:
	if Ship.shields_energy < 5:
		Ship.shields_energy = Ship.shields_energy
		return
	if left == 100:
		return
	shield_up_sound.play()
	left = clamp(left + 20, 0, 100)
	update_left_shield()
	Ship.shields_energy -= 5

func _on_alien_fight_start() -> void:
	alien_fight_started = true
	alien_shots_fired_timer.wait_time = 6
	alien_shots_fired_timer.start()

func _on_alien_fight_completed() -> void:
	alien_fight_started = false
	alien_shots_fired_timer.stop()

func _on_alien_fight_timer_timeout() -> void:
	alien_shots_fired_timer.stop()
	Game.alien_fight_completed.emit()

func _on_alien_shots_fired_timer_timeout() -> void:
	shield_damage_sound.play()
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
