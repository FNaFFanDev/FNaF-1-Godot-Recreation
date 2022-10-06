extends Node2D

onready var fade_anim = $Fade/AnimationPlayer
#Declaring the timer

func _ready():
	fade_anim.play("Fade in")
#Making the screen fade in


func _on_Timer_timeout():
	fade_anim.play("Fade out")
#Making the screen fade out when the timer runs out

func _input(event):
	if event is InputEventMouseButton and event.pressed and event.button_index == BUTTON_LEFT:
		fade_anim.play("Fade out")
#Making it so that you can skip the newspaper. You couldn't do this in the original game, but it's a good quality of life improvement.


func _on_AnimationPlayer_animation_finished(anim_name):
	if anim_name == "Fade out":
		get_tree().change_scene("res://Night preview/Assets/Night preview.tscn")
