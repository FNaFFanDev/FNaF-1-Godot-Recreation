extends Node2D

onready var background = $Background
onready var night_preview = $"Continue button/Night preview"
onready var blip = $Blipflash
onready var night_num = $"Continue button/Night preview/AnimatedSprite"
onready var night_5_star = $"Stars/Night 5"
onready var night_6_star = $"Stars/Night 6"
onready var max_mode_star = $"Stars/20 mode"
onready var night_6_button = $"6th Night Button"
onready var custom_night_button = $"Custom Night"
#Declaring objects used in script

var rng = RandomNumberGenerator.new()
var twitch = 0
var blip_visibility = 0
var blip_flash = 0
var data = {
	"Night": 1,
	"Beatgame": 0,
	"Lives": 5
}

#Declaring variables

func _ready():
	GlobalMusic.play_menu_music()
	var file = File.new()
	if file.file_exists(NightSaving.Save_Path):
		var error = file.open(NightSaving.Save_Path, File.READ)
		if error == OK:
			data = file.get_var()
			file.close()
	rng.randomize()
	
	if data["Night"] > 5:
		data["Night"] = 5

	match data["Beatgame"]:
		0: 
			night_5_star.visible = false
			night_6_star.visible = false
			max_mode_star.visible = false
			night_6_button.visible = false
			custom_night_button.visible = false
		1:
			night_5_star.visible = true
			night_6_star.visible = false
			max_mode_star.visible = false
			night_6_button.visible = true
			custom_night_button.visible = false
		2:
			night_6_star.visible = true
			max_mode_star.visible = false
			custom_night_button.visible = true
		3:
			max_mode_star.visible = true
#Calling functions that need to start with the scene

func _physics_process(delta):
	twitching()
#Calling functions that need to be repeated every frame

func _on_Twitch_timer_timeout():
	twitch = rng.randi_range(0, 3)
#Making the twitching random

func twitching():
	match twitch:
		0: background.play("default")
		1: background.play("Twitch 1")
		2: background.play("Twitch 2")
		3: background.play("Twitch 3")
#Showing the twitching on screen


func _on_New_game_button_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton and event.pressed and event.button_index == BUTTON_LEFT:
		get_tree().change_scene("res://Newspaper/Assets/Newspaper.tscn")
	#Pressing the new game button will take you to the newspaper 
		var file = File.new()
		file.open(NightSaving.Save_Path, file.WRITE)
		data["Night"] = 1
		file.store_var(data)
		file.close()
#Pressing the new game button will reset the night value to 1

func _on_Continue_button_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton and event.pressed and event.button_index == BUTTON_LEFT:
		get_tree().change_scene("res://Night preview/Assets/Night preview.tscn")
		if data["Night"] > 5:
			var file = File.new()
			file.open(NightSaving.Save_Path, file.WRITE)
			data["Night"] = 5
			file.store_var(data)
			file.close()
#Pressing the continue button will directly go to the night preview screen. If the night is higher than 5, it will set it back to 5.

func _on_Continue_button_mouse_entered():
	night_preview.visible = true
	match data["Night"]:
		1: night_num.play("Night 1")
		2: night_num.play("Night 2")
		3: night_num.play("Night 3")
		4: night_num.play("Night 4")
		5: night_num.play("Night 5")
#Showing the night text bellow the continue button and what night the player is on

func _on_Continue_button_mouse_exited():
	night_preview.visible = false
#Hiding the night text bellow the continue button


func _on_Timer_timeout():
	blip_visibility = rng.randi_range(0, 1)
	randomize()
	blip_flash = rng.randi_range(1, 3)
	blipflash()
#Making the blipflash object appear and change animations at random

func blipflash():
	if blip_visibility == 1:
		blip.visible = true
	else: 
		blip.visible = false
	match blip_flash:
		1: blip.play("Blip 1")
		2: blip.play("Blip 2")
		3: blip.play("Blip 3")
#Showing blipflash object on screen

func _on_Blipflash_animation_finished():
	blip.visible = false

func _on_Development_Settings_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton and event.pressed and event.button_index == BUTTON_LEFT:
		get_tree().change_scene("res://Development menu/Assets/Developer Menu.tscn")
#Button for the development menu


func _on_6th_Night_Button_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton and event.pressed and event.button_index == BUTTON_LEFT:
		get_tree().change_scene("res://Night preview/Assets/Night preview.tscn")
		var file = File.new()
		file.open(NightSaving.Save_Path, File.WRITE)
		data["Night"] = 6
		file.store_var(data)
		file.close()


func _on_Custom_Night_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton and event.pressed and event.button_index == BUTTON_LEFT:
		get_tree().change_scene("res://Custom Night Menu/Assets/Custom Night Menu.tscn")
