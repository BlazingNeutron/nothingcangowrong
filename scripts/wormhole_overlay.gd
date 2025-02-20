extends Control

signal wormhole_overlay_complete

@onready var wormhole_warping_effect: ColorRect = $WormholeWarpingEffect
@onready var wormhole_effect: Timer = $WormholeEffect
@onready var wormhole_colour_effect: ColorRect = $WormholeColourEffect

func start_wormhole_overlay() -> void:
	wormhole_effect.start()
	wormhole_warping_effect.show()

func overlay_complete() -> void:
	wormhole_warping_effect.show()
	emit_signal("wormhole_overlay_complete")
