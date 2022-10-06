extends Node2D

var data

onready var anim_player = $AnimationPlayer


func _ready():
	anim_player.play("6 AM")
	var file = File.new()
	if file.file_exists(NightSaving.Save_Path):
		var error = file.open(NightSaving.Save_Path, File.READ)
		if error == OK:
			data = file.get_var()
			file.close()
	
	if data["Night"] < 5:
		file.open(NightSaving.Save_Path, File.WRITE)
		match data["Night"]:
			1: data["Night"] = 2
			2: data["Night"] = 3
			3: data["Night"] = 4
			4: data["Night"] = 5
		file.store_var(data)
		file.close()
#Making the night go up

func _on_AnimationPlayer_animation_finished(anim_name):
	if data["Night"] > 5:
		get_tree().change_scene("res://Paycheck/Assets/Paycheck.tscn")
	else:
		get_tree().change_scene("res://Night preview/Assets/Night preview.tscn")
