extends "res://scripts/panel.gd"

@onready var unstable_reactions: Node2D = $UnstableReactions
@onready var spawn_timer: Timer = $UnstableReactions/SpawnTimer

var unstable_reaction = preload("res://scenes/unstable_reaction.tscn")
var unstable_reaction_elements = []
var destabilization_started = false
var unstable_reactions_destroyed = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	randomize()
	Game.connect("core_destabilization_started", _on_core_destabilization_started)

func _on_core_destabilization_started() -> void:
	destabilization_started = true
	spawn_timer.start()
	unstable_reactions_destroyed = 0

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if destabilization_started:
		for element in unstable_reaction_elements:
			var moveX = randi_range(-10, 10)
			var moveY = randi_range(-10, 10)
			var newPosX = element.position.x + moveX
			if newPosX > 75:
				newPosX = 75
			if newPosX < -75:
				newPosX = -75
			var newPosY = element.position.y + moveY
			if newPosY > 75:
				newPosY = 75
			if newPosY < -75:
				newPosY = -75
			element.position.x = newPosX
			element.position.y = newPosY

func _on_spawn_timer_timeout() -> void:
	if unstable_reaction_elements.size() == 10:
		get_tree().change_scene_to_file("res://scenes/GameOverExplosion.tscn")
	var posY = randi_range(-50, 50)
	var posX = randi_range(-50, 50)
	var new_element = unstable_reaction.instantiate()
	new_element.position.x = posX
	new_element.position.y = posY
	unstable_reactions.add_child(new_element)
	unstable_reaction_elements.push_back(new_element)
	# next ion spawn at random interval
	spawn_timer.wait_time = randf_range(0.5, 2.5)

func _on_discharge_button_pressed() -> void:
	while unstable_reaction_elements.size() > 0:
		var element = unstable_reaction_elements.pop_front()
		unstable_reactions_destroyed += 1
		element.queue_free()
		if unstable_reactions_destroyed >= 28:
			core_stabilized()
	Ship.energy_drain()

func core_stabilized() -> void:
	destabilization_started = false
	unstable_reactions_destroyed = 0
	spawn_timer.stop()
	Game.core_stabilized()
	while unstable_reaction_elements.size() > 0:
		var element = unstable_reaction_elements.pop_front()
		unstable_reactions_destroyed += 1
		element.queue_free()
