extends Node2D

@onready var story_timer: Timer = $StoryTimer

var game_story = null
var index = 0

func _ready() -> void:
	Game.connect("story_start", restart_game)
	story_timer.connect("timeout", _on_next_message_timeout)
	var file = FileAccess.get_file_as_string("res://assets/story/story.json")
	game_story = JSON.parse_string(file)

func restart_game() -> void:
	story_timer.start()

func _on_next_message_timeout() -> void:
	if game_story.story[index].trigger == "listener":
		Game.disconnect(game_story.story[index].listen, _on_next_message_timeout)
	if game_story.story[index].chat:
		var sender_color = game_story.story[index].color
		var sender_name = game_story.story[index].name
		var sender_message = game_story.story[index].message
		Game.receive_chat_message(sender_color, sender_name, sender_message)
	if game_story.story[index].events:
		for event in game_story.story[index].events:
			Game.fire_event(event)
	
	index += 1
	if game_story.story[index].trigger == "timer":
		var next_time = game_story.story[index].time
		story_timer.wait_time = next_time
		story_timer.start()
	if game_story.story[index].trigger == "listener":
		Game.connect(game_story.story[index].listen, _on_next_message_timeout)
