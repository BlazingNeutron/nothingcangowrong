extends Control

@onready var wormhole_warping_effect: ColorRect = $WormholeWarpingEffect
@onready var wormhole_effect: Timer = $WormholeEffect
@onready var wormhole_colour_effect: ColorRect = $WormholeColourEffect

var hide_color = false

func _ready() -> void:
	Game.wormhole_start.connect(start_wormhole_overlay)
	Game.core_stabilization_complete.connect(complete_wormhole_overlay)

func start_wormhole_overlay() -> void:
	wormhole_effect.start()
	wormhole_warping_effect.show()
	wormhole_colour_effect.show()
	hide_color = false

func complete_wormhole_overlay() -> void:
	wormhole_effect.start()
	wormhole_warping_effect.show()
	hide_color = true

func overlay_complete() -> void:
	wormhole_warping_effect.hide()
	if hide_color:
		wormhole_colour_effect.hide()
	else:
		Game.start_core_destabilization()
