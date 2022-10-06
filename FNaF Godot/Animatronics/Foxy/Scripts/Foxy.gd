extends Node2D

onready var block_timer = $Timer2

var AI = 1
var movement_opportunity = 1
var map_position = 1
var rng = RandomNumberGenerator.new()
var blocked = false
var its_me = 0
var data
#Defining variables

func _ready():
	var file = File.new()
	if file.file_exists(NightSaving.Save_Path):
		var error = file.open(NightSaving.Save_Path, File.READ)
		if error == OK:
			data = file.get_var()
			file.close()
	
	match data["Night"]:
		1: AI = 0
		2: AI = 1
		3: AI = 2
		4: AI = 6
		5: AI = 5
		6: AI = 16
		7: AI = NightSaving.Foxy_AI

func _on_Timer_timeout():
	movement_opportunity = rng.randi_range(1, 20)
	rng.randomize()
	if AI >= movement_opportunity and blocked == false:
		match map_position:
			1: map_position = 2
			2: map_position = 3
			3: map_position = 4
	
	its_me = rng.randi_range(0, 1)
#Making foxy cycle through his stages


func _on_camera_down():
	blocked = false
