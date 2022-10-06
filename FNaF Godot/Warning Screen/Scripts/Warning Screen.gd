extends Node2D

onready var fade_transition = $Fade/AnimationPlayer 
#Declaring the fade transition

func _on_Timer_timeout(): 
	fade_transition.play("Fade out")
#Fading in 

func _on_AnimationPlayer_animation_finished(anim_name):
	if anim_name == "Fade out":
		get_tree().change_scene("res://Main Menu/Assets/Main Menu.tscn")
#Fading out and changing scene to the menu
