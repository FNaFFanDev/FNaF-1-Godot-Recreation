extends Node2D

onready var door = $AnimatedSprite
var status = 0

func _physics_process(delta):
	if status == 1:
		door.play("Closing")
	elif status == 2:
		door.play("Opening")





func _on_AnimatedSprite_animation_finished():
	if door.animation == "Opening":
		status = 0
