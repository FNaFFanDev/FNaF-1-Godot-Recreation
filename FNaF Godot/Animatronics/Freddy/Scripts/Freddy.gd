extends Node2D

onready var anim = $AnimationPlayer
onready var scare_timer = $"Jumpscare timer"
onready var laugh_1 = load("res://FNaF 1/FNaF 1 Audio/Laugh_Giggle_Girl_8d.wav")
onready var laugh_2 = load("res://FNaF 1/FNaF 1 Audio/Laugh_Giggle_Girl_1d.wav")
onready var laugh_3 = load("res://FNaF 1/FNaF 1 Audio/Laugh_Giggle_Girl_2d.wav")
onready var laugh = $AudioStreamPlayer

var AI = 1
var movement_opportunity = 1
var map_position = 1
var rng = RandomNumberGenerator.new()
var locked = false
var jumpscare = false
var data
var what_laugh = 0

func _ready():
	var file = File.new()
	if file.file_exists(NightSaving.Save_Path):
		var error = file.open(NightSaving.Save_Path, File.READ)
		if error == OK:
			data = file.get_var()
			file.close()
	
	match data["Night"]:
		1: AI = 0
		2: AI = 0
		3: AI = 1
		4: AI = rng.randi_range(1, 2)
		5: AI = 3
		6: AI = 4
		7: AI = NightSaving.Freddy_AI
func _physics_process(delta):
	if map_position == 7:
		anim.play("Warning")
	else:
		anim.play("Default")

func _on_Timer_timeout():
	rng.randomize()
	movement_opportunity = rng.randi_range(1, 20)
	what_laugh = rng.randi_range(1, 3)
	
	match what_laugh:
		1: laugh.stream = laugh_1
		2: laugh.stream = laugh_2
		3: laugh.stream = laugh_3
	
	if AI >= movement_opportunity and locked == false:
		match map_position:
			1: map_position = 2
			2: map_position = 3
			3: map_position = 4 
			4: map_position = 5
			5: map_position = 6
			6: map_position = 7
		laugh.play()
	
	print(what_laugh)
func _on_Jumpscare_timer_timeout():
	jumpscare = true
