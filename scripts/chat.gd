extends Node2D

@onready var next_message: Timer = $NextMessage
@onready var chat_output: RichTextLabel = $ChatOutput
@onready var notification: AudioStreamPlayer2D = $AudioStreamPlayer2D

var current_time = 0
var message_index = 0

var messages = [
	[0, "red]Captain", "Good day crew! Today we will be launching into our new journey to Alpha Centauri and I expect a full report from all teams before end of day. Please keep in mind that this should be a fairly easy trip where nothing can possibly go wrong.", false],
	[10, "red]Captain", "I forgot to mention that we have a new staff member... I suppose that is the first thing to ever go wrong...", false],
	[20, "red]Captain", "Everyone please welcome our new engineer!", false],
	[25, "blue]Supervisor", "Hey noob welcome aboard. I will be busy doing reports today, but just know that you have to pay attention to the control panel and I am sure you will figure it out.", false],
	[35, "blue]Supervisor", "Ok, ok... I guess one thing to remember is you will need to keep an eye on the power output to the system core and to the sensors. All of the other systems should be running on a surplus of fuel for about the first day after departure.", true],
	[45, "blue]Supervisor", "I know you already know this, but this model of warp engine will actually implode from dark matter ionization if the core power gauge ever drops to 0.", false],
	[55, "blue]Supervisor", "I don't know who designs these things, honestly... Good luck!", false]
]

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	next_message.start()

func _on_next_message_timeout() -> void:
	notification.play()
	current_time = messages[message_index][0]
	chat_output.append_text("<[i][color=" + messages[message_index][1] + "[/color][/i]>:\n")
	chat_output.append_text(messages[message_index][2]+"\n")
	if messages[message_index][3]:
		Game.fire_event("tutorial_overlay_start")
	
	message_index += 1
	if message_index < messages.size():
		var next_time = messages[message_index][0] - current_time
		next_message.wait_time = next_time
		next_message.start()
