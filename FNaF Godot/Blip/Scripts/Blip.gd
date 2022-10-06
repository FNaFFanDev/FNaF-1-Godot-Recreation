extends Node2D

onready var blip = $AnimatedSprite

func _ready():
	blip.play("Blip")

func _on_AnimatedSprite_animation_finished():
	queue_free()
