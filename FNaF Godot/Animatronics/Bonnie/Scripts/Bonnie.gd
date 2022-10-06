extends Node2D

onready var anim = $AnimationPlayer

var AI = 1
var movement_opportunity = 1
var map_position = 1
var rng = RandomNumberGenerator.new()
var path = 1
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
		2: AI = 3
		3: AI = 0
		4: AI = 2
		5: AI = 5
		6: AI = 10
		7: AI = NightSaving.Bonnie_AI
func _physics_process(delta):
	if map_position == 7:
		anim.play("Warning")
	else:
		anim.play("Normal")

func _on_Timer_timeout():
	movement_opportunity = rng.randi_range(1, 20)
	path = rng.randi_range(1, 2)
	rng.randomize()
	if AI >= map_position:
		match map_position:
			1: map_position = rng.randi_range(2, 3)
			2: map_position = rng.randi_range(3, 4)
			3: 
				if path == 1:
					map_position = 2
				else:
					map_position = 4
			4: 
				if path == 1:
					map_position = 5
				else:
					map_position = 6
			5: map_position = rng.randi_range(5, 6)
			6: map_position = 7
#Making bonnie move
