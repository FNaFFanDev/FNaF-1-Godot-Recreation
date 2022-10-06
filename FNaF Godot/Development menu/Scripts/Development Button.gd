extends Node2D

onready var arrow = $Arrow

var pressed = false


func _physics_process(delta):
	if pressed == true:
		arrow.visible = true
	else:
		arrow.visible = false

func _on_Button_pressed():
	pressed = true


func _on_cheats_pressed():
	pass # Replace with function body.
