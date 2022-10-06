extends Node2D

onready var tv_static = $AnimatedSprite
#Declaring the static 
var static_rng = RandomNumberGenerator.new()



func _on_Timer_timeout():
	tv_static.modulate.a = static_rng.randf_range(0.3, 0.6)
	static_rng.randomize()
