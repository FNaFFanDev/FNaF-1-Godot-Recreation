extends Area2D

onready var monitor = $Monitor
onready var blip = preload("res://Blip/Assets/Blip.tscn")
onready var sound = $camsound
onready var cam_up = load("res://FNaF 1/FNaF 1 Audio/CAMERA_VIDEO_LOA_60105303.wav")
onready var cam_down = load("res://FNaF 1/FNaF 1 Audio/put down.wav")
var status = 0

func _physics_process(delta):
	if status == 2 or status == 0:
		monitor.visible = false
	else:
		monitor.visible = true
#Hiding or showing the monitor at appropriate times

func _on_Camera_Trigger_mouse_entered():
	if status == 0:
		status = 1
		sound.stream = cam_up
		sound.play()
		monitor.play("Cam Up")
	elif status == 2:
		status = 3
		sound.stream = cam_down
		sound.play()
		monitor.play("Cam Down")

#Making the trigger control the camera

func _on_Monitor_animation_finished():
	if monitor.animation == "Cam Up":
		status = 2
		var blipflash = blip.instance()
		get_parent().add_child(blipflash)
		blipflash.position = monitor.global_position
	
	elif monitor.animation == "Cam Down":
		status = 0
#Making the cameras work
