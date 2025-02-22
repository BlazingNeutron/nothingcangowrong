extends Node2D

@onready var chat_output: RichTextLabel = $ChatOutput
@onready var notification_sound: AudioStreamPlayer2D = $notifiers/NotificationSound
@onready var animation_player: AnimationPlayer = $notifiers/NotificationIcon/AnimationPlayer


func _ready() -> void:
	Game.chat_message.connect(_on_new_chat_message)

func _on_new_chat_message(color, sender_name, message) -> void:
	notification_sound.play()
	animation_player.play("notify_icon_blink")
	chat_output.append_text("<[i][color=" + color + "]" + sender_name + "[/color][/i]>:\n" + message + "\n\n")
