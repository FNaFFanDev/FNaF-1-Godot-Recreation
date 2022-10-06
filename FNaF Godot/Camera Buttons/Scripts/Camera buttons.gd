extends Node2D

onready var cam_1_a = $"Cam 1A/AnimatedSprite"
onready var cam_1_b = $"Cam 1B/AnimatedSprite"
onready var cam_1_c = $"Cam 1C/AnimatedSprite"
onready var cam_2_a = $"Cam 2A/AnimatedSprite"
onready var cam_2_b = $"Cam 2B/AnimatedSprite"
onready var cam_3 = $"Cam 3/AnimatedSprite"
onready var cam_4_a = $"Cam 4A/AnimatedSprite"
onready var cam_4_b = $"Cam 4B/AnimatedSprite"
onready var cam_5 = $"Cam 5/AnimatedSprite"
onready var cam_6 = $"Cam 6/AnimatedSprite"
onready var cam_7 = $"Cam 7/AnimatedSprite"
onready var cam_1_a_label = $"Cam 1A/Sprite"
onready var cam_1_b_label = $"Cam 1B/Sprite"
onready var cam_1_c_label = $"Cam 1C/Sprite"
onready var cam_2_a_label = $"Cam 2A/Sprite"
onready var cam_2_b_label = $"Cam 2B/Sprite"
onready var cam_3_label = $"Cam 3/Sprite"
onready var cam_4_a_label = $"Cam 4A/Sprite"
onready var cam_4_b_label = $"Cam 4B/Sprite"
onready var cam_5_label = $"Cam 5/Sprite"
onready var cam_6_label = $"Cam 6/Sprite"
onready var cam_7_label = $"Cam 7/Sprite"
onready var blip_position = $Blippos
onready var blip = preload("res://Blip/Assets/Blip.tscn")
onready var blip_sound = $"Blip_sound"
#declaring the camera buttons
var cam = 1

func _on_cam_1_pressed():
	cam = 1
	var blipflash = blip.instance()
	get_parent().add_child(blipflash)
	blipflash.position = blip_position.global_position
	blip_sound.play()
func _on_cam_2_pressed():
	cam = 2
	var blipflash = blip.instance()
	get_parent().add_child(blipflash)
	blipflash.position = blip_position.global_position
	blip_sound.play()

func _on_cam_3_pressed():
	cam = 3
	var blipflash = blip.instance()
	get_parent().add_child(blipflash)
	blipflash.position = blip_position.global_position
	blip_sound.play()

func _on_cam_4_pressed():
	cam = 4
	var blipflash = blip.instance()
	get_parent().add_child(blipflash)
	blipflash.position = blip_position.global_position
	blip_sound.play()

func _on_cam_5_pressed():
	cam = 5
	var blipflash = blip.instance()
	get_parent().add_child(blipflash)
	blipflash.position = blip_position.global_position
	blip_sound.play()

func _on_cam_6_pressed():
	cam = 6
	var blipflash = blip.instance()
	get_parent().add_child(blipflash)
	blipflash.position = blip_position.global_position
	blip_sound.play()

func _on_cam_7_pressed():
	cam = 7
	var blipflash = blip.instance()
	get_parent().add_child(blipflash)
	blipflash.position = blip_position.global_position
	blip_sound.play()

func _on_cam_8_pressed():
	cam = 8
	var blipflash = blip.instance()
	get_parent().add_child(blipflash)
	blipflash.position = blip_position.global_position
	blip_sound.play()

func _on_cam_9_pressed():
	cam = 9
	var blipflash = blip.instance()
	get_parent().add_child(blipflash)
	blipflash.position = blip_position.global_position
	blip_sound.play()

func _on_cam_10_pressed():
	cam = 10
	var blipflash = blip.instance()
	get_parent().add_child(blipflash)
	blipflash.position = blip_position.global_position
	blip_sound.play()

func _on_cam_11_pressed():
	cam = 11
	var blipflash = blip.instance()
	get_parent().add_child(blipflash)
	blipflash.position = blip_position.global_position
	blip_sound.play()

func _physics_process(delta):
	cam_button_anim_change()
	
	if NightSaving.old_cameras == true:
		cam_1_a.visible = false
		cam_1_b.visible = false
		cam_1_c.visible = false
		cam_2_a.visible = false
		cam_2_b.visible = false
		cam_3.visible = false
		cam_4_a.visible = false
		cam_4_b.visible = false
		cam_5.visible = false
		cam_6.visible = false
		cam_7.visible = false
		cam_1_a_label.visible = false
		cam_1_b_label.visible = false
		cam_1_c_label.visible = false
		cam_2_a_label.visible = false
		cam_2_b_label.visible = false
		cam_3_label.visible = false
		cam_4_a_label.visible = false
		cam_4_b_label.visible = false
		cam_5_label.visible = false
		cam_6_label.visible = false
		cam_7_label.visible = false
	else:
		cam_1_a.visible = true
		cam_1_b.visible = true
		cam_1_c.visible = true
		cam_2_a.visible = true
		cam_2_b.visible = true
		cam_3.visible = true
		cam_4_a.visible = true
		cam_4_b.visible = true
		cam_5.visible = true
		cam_6.visible = true
		cam_7.visible = true
		cam_1_a_label.visible = true
		cam_1_b_label.visible = true
		cam_1_c_label.visible = true
		cam_2_a_label.visible = true
		cam_2_b_label.visible = true
		cam_3_label.visible = true
		cam_4_a_label.visible = true
		cam_4_b_label.visible = true
		cam_5_label.visible = true
		cam_6_label.visible = true
		cam_7_label.visible = true
#Calling all functions that need to constantly play

func cam_button_anim_change():
	if cam == 1:
		cam_1_a.play("Active")
	else:
		cam_1_a.play("default")
	
	if cam == 2:
		cam_1_b.play("Active")
	else:
		cam_1_b.play("default")
	
	if cam == 3:
		cam_1_c.play("Active")
	else:
		cam_1_c.play("default")
	
	if cam == 4:
		cam_2_a.play("Active")
	else:
		cam_2_a.play("default")
	
	if cam == 5:
		cam_2_b.play("Active")
	else:
		cam_2_b.play("default")
	
	if cam == 6:
		cam_3.play("Active")
	else:
		cam_3.play("default")
	
	if cam == 7:
		cam_4_a.play("Active")
	else: 
		cam_4_a.play("default")
	
	if cam == 8:
		cam_4_b.play("Active")
	else:
		cam_4_b.play("default")
	
	if cam == 9:
		cam_5.play("Active")
	else:
		cam_5.play("default")
	
	if cam == 10:
		cam_6.play("Active")
	else:
		cam_6.play("default")
	
	if cam == 11:
		cam_7.play("Active")
	else:
		cam_7.play("default")
#Changing camera button animations

