extends Node2D



func _on_Timer_timeout():
	get_tree().change_scene("res://Game Over/Assets/Game Over.tscn")
