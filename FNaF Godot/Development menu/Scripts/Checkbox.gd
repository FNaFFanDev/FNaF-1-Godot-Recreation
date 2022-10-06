extends Node2D

onready var box = $AnimatedSprite
var active = false


func _physics_process(delta):
	if active == true:
		box.play("Pressed")
	else:
		box.play("default")

func _on_Button_pressed():
	active = !active


