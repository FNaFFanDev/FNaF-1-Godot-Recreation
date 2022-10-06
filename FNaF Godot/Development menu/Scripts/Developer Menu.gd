extends Node2D

onready var cheat_button = $"Cheats Button"
onready var beta_content_button = $"Beta Content Button"
onready var cheats = $Cheats
onready var beta =  $Beta
onready var radar = $Cheats/Radar
onready var infinite_power = $"Cheats/Infinite Power"
onready var lives = $Beta/Lives
onready var old_cameras = $"Beta/Old Cameras"
onready var night_string = $"Cheats/Night String"
onready var beatgame_string = $"Cheats/Beatgame String"
var data

func _ready():
	var file = File.new()
	if file.file_exists(NightSaving.Save_Path):
		var error = file.open(NightSaving.Save_Path, File.READ)
		if error == OK:
			data = file.get_var()
			file.close()
	
	radar.active = NightSaving.radar
	infinite_power.active = NightSaving.infinite_power
	lives.active = NightSaving.lives
	old_cameras.active = NightSaving.old_cameras

func _physics_process(delta):
	night_string.text = String(data["Night"])
	beatgame_string.text = String(data["Beatgame"])
	
	if cheat_button.pressed == true:
		cheats.visible = true
	else:
		cheats.visible = false
	
	if beta_content_button.pressed == true:
		beta.visible = true
	else:
		beta.visible = false
	
	match radar.active:
		true: NightSaving.radar = true
		false: NightSaving.radar = false
	
	match infinite_power.active:
		true: NightSaving.infinite_power = true
		false: NightSaving.infinite_power = false
	
	match lives.active:
		true: NightSaving.lives = true
		false: NightSaving.lives = false
	
	match old_cameras.active:
		true: NightSaving.old_cameras = true
		false: NightSaving.old_cameras = false

func _on_cheats_pressed():
	beta_content_button.pressed = false

func _on_beta_pressed():
	cheat_button.pressed = false


func _on_return_to_menu():
	var file = File.new()
	file.open(NightSaving.Save_Path, File.WRITE)
	file.store_var(data)
	file.close()
	get_tree().change_scene("res://Main Menu/Assets/Main Menu.tscn")


func _on_add_to_night():
	if data["Night"] < 5:
		data["Night"] += 1


func _on_subtract_from_night():
	if data["Night"] > 1:
		data["Night"] -= 1


func _on_add_to_beatgame():
	if data["Beatgame"] < 3:
		data["Beatgame"] += 1


func _on_subtract_from_beatgame():
	if data["Beatgame"] > 0:
		data["Beatgame"] -= 1
