extends Node2D

onready var jumpscare = $AnimatedSprite

func _on_AnimatedSprite_animation_finished():
	get_tree().change_scene("res://Game Over/Assets/Game Over Static.tscn")


func _on_Timer_timeout():
	jumpscare.play("default")
