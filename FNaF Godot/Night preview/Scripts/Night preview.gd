extends Node2D

onready var whatnight = $AnimatedSprite
onready var blip_sound = $"Blip Sound"
#Declaring the night text
var data

func _ready():
	blip_sound.play()
	GlobalMusic.stop_music()
	var file = File.new()
	if file.file_exists(NightSaving.Save_Path):
		var error = file.open(NightSaving.Save_Path, File.READ)
		if error == OK:
			data = file.get_var()
			file.close()
		
	what_night()
#Calling the what night function at the beginning of the scene

func what_night():
	match data["Night"]:
		1: whatnight.play("Night 1")
		2: whatnight.play("Night 2")
		3: whatnight.play("Night 3")
		4: whatnight.play("Night 4")
		5: whatnight.play("Night 5")
		6: whatnight.play("Night 6")
		7: whatnight.play("Night 7")
#Showing what night the player is on


func _on_Timer_timeout():
	get_tree().change_scene("res://Loading/Assets/Loading Screen.tscn")
