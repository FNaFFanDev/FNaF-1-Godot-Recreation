extends Node2D

onready var anim = $AnimationPlayer

var AI = 1
var movement_opportunity = 1
var map_position = 1
var rng = RandomNumberGenerator.new()
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
		3: AI = 5
		4: AI = 4
		5: AI = 7
		6: AI = 12
		7: AI = NightSaving.Chica_AI

func _physics_process(delta):
	if map_position == 7:
		anim.play("Warning")
	else:
		anim.play("Normal")

func _on_Timer_timeout():
	movement_opportunity = rng.randi_range(1, 20)
	rng.randomize()
	if AI >= movement_opportunity:
		match map_position:
			1: map_position = 2
			2: map_position = 3
			3: map_position = 4
			4: map_position = 5
			5: map_position = 6
			6: map_position = 7
