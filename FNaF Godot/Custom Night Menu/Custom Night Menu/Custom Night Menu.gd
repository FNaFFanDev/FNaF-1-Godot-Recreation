extends Node2D

onready var Freddy_Counter = $"Freddy AI"
onready var Bonnie_Counter = $"Bonnie AI"
onready var Chica_Counter = $"Chica AI"
onready var Foxy_Counter = $"Foxy AI"

var data

func _ready():
	var file = File.new()
	if file.file_exists(NightSaving.Save_Path):
		var error = file.open(NightSaving.Save_Path, File.READ)
		if error == OK:
			data = file.get_var()
			file.close()

func _physics_process(delta):
	Freddy_Counter.text = String(NightSaving.Freddy_AI)
	Bonnie_Counter.text = String(NightSaving.Bonnie_AI)
	Chica_Counter.text = String(NightSaving.Chica_AI)
	Foxy_Counter.text = String(NightSaving.Foxy_AI)

func _on_ready_button_pressed():
	var file = File.new()
	file.open(NightSaving.Save_Path, File.WRITE)
	data["Night"] = 7
	file.store_var(data)
	file.close()
	get_tree().change_scene("res://Night preview/Assets/Night preview.tscn")

func _on_Freddy_AI_up_pressed():
	if NightSaving.Freddy_AI < 20:
		NightSaving.Freddy_AI += 1
	else:
		NightSaving.Freddy_AI = 0


func _on_Freddy_AI_down_pressed():
	if NightSaving.Freddy_AI > 0:
		NightSaving.Freddy_AI -= 1
	else:
		NightSaving.Freddy_AI = 20


func _on_Bonnie_AI_up_pressed():
	if NightSaving.Bonnie_AI < 20:
		NightSaving.Bonnie_AI += 1
	else:
		NightSaving.Bonnie_AI = 0


func _on_Bonnie_AI_down_pressed():
	if NightSaving.Bonnie_AI > 0:
		NightSaving.Bonnie_AI -= 1
	else:
		NightSaving.Bonnie_AI = 20


func _on_Chica_AI_up_pressed():
	if NightSaving.Chica_AI < 20:
		NightSaving.Chica_AI += 1
	else:
		NightSaving.Chica_AI = 0


func _on_Chica_AI_down_pressed():
	if NightSaving.Chica_AI > 0:
		NightSaving.Chica_AI -= 1
	else:
		NightSaving.Chica_AI = 20


func _on_Foxy_AI_up_pressed():
	if NightSaving.Foxy_AI < 20:
		NightSaving.Foxy_AI += 1
	else:
		NightSaving.Foxy_AI = 0


func _on_Foxy_AI_down_pressed():
	if NightSaving.Foxy_AI > 0:
		NightSaving.Foxy_AI -= 1
	else:
		NightSaving.Foxy_AI = 20
