extends Node2D

onready var Buttons = $AnimatedSprite
onready var door_button = $"Door Button"
onready var light_button = $"Light Button"
onready var sound = $AudioStreamPlayer
onready var door_slam = load("res://FNaF 1/FNaF 1 Audio/SFXBible_12478.wav")
onready var jammed_sound = load("res://FNaF 1/FNaF 1 Audio/error.wav")
var door_pressed = false
var light_pressed = false
var door = 0
var jammed = false
#Setting up variables for the buttons

func _physics_process(delta):
	if jammed == false:
		match [door_pressed, light_pressed]:
			[false, false]: Buttons.play("default")
			[true, false]: Buttons.play("Door")
			[false, true]: Buttons.play("Light")
			[true, true]: Buttons.play("Door And Light")
	else:
		Buttons.play("default")
#Showing the appropriate animations depending on what buttons are pressed

func _on_Door_Button_pressed():
	if door_pressed == false and jammed == false:
		door_pressed = true
		door += 1
	else:
		door_pressed = false
	
	if jammed == false:
		sound.stream = door_slam
		sound.play()
	else:
		sound.stream = jammed_sound
		sound.play()
#Making it so that pressing the door button changes the button animation depending on weather it's pressed or not
#Setting up the value for the door

func _on_Light_Button_pressed():
	if light_pressed == false and jammed == false:
		light_pressed = true
	else:
		light_pressed = false
	
	if jammed == true:
		sound.stream == jammed_sound
		sound.play()
#Making it so that pressing the light button changes the button animation depending on weather it's pressed or not
