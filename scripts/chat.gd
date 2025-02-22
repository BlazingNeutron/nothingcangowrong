extends Node2D

@onready var chat_output: RichTextLabel = $ChatOutput
@onready var notification_player: AudioStreamPlayer2D = $AudioStreamPlayer2D

func _ready() -> void:
	Game.connect("chat_message", _on_new_chat_message)

func _on_new_chat_message(color, sender_name, message) -> void:
	notification_player.play()
	chat_output.append_text("<[i][color=" + color + "]" + sender_name + "[/color][/i]>:\n" + message + "\n\n")
