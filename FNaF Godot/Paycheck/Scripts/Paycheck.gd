extends Node2D

onready var paycheck = $AnimatedSprite
onready var anim = $Fade/AnimationPlayer

var data

# Called when the node enters the scene tree for the first time.
func _ready():
	var file = File.new()
	if file.file_exists(NightSaving.Save_Path):
		var error = file.open(NightSaving.Save_Path, File.READ)
		if error == OK:
			data = file.get_var()
			file.close()
	
	match data["Night"]:
		5: paycheck.play("Night 5")
		6: paycheck.play("Night 6")
		7: paycheck.play("Night 7")
	
	match data["Night"]:
		5: data["Beatgame"] = 1
		6: data["Beatgame"] = 2
		7:
			if NightSaving.Freddy_AI == 20 and NightSaving.Bonnie_AI == 20 and NightSaving.Chica_AI == 20 and NightSaving.Foxy_AI == 20:
				data["Beatgame"] = 3
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_AnimationPlayer_animation_finished(anim_name):
	if anim_name == "Fade out":
		var file = File.new()
		file.open(NightSaving.Save_Path, File.WRITE)
		file.store_var(data)
		file.close()
		get_tree().change_scene("res://Main Menu/Assets/Main Menu.tscn")


func _on_Timer_timeout():
	anim.play("Fade out")

func _on_Button_pressed():
	anim.play("Fade out")
