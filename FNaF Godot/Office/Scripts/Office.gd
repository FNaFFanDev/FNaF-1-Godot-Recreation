extends Node2D

onready var camera = $Camera2D
onready var office = $Background
onready var door_button_L = $"Door Button L"
onready var door_button_L_anim = $"Door Button L/AnimatedSprite"
onready var door_button_R = $"Door Button R"
onready var door_L = $"Door L"
onready var door_R = $"Door R"
onready var usage_bar = $"UI/Usage Text/Usage"
onready var power_timer = $"UI/Power Left/Timer"
onready var fan = $Background/Fan
onready var UI = $UI
onready var power = $"UI/Power Left"
onready var power_out_flicker = $"Power Outage Flicker"
onready var power_anim = $"Power Outage Flicker/AnimationPlayer"
onready var powerout_timer = $"Power Outage Timer"
onready var Freddy_duration = $"Freddy Duration"
onready var scare_timer_powerout = $"Scaretimer powerout"
onready var time_label = $UI/AM/Time
onready var night_text = $"UI/Night/Night Text"
onready var monitor = $"UI/Camera Trigger"
onready var cam_UI = $"Cams/Cam UI"
onready var cam_parent = $Cams
onready var cam_map = $"Cams/Cam UI/Minimap"
onready var cam_buttons = $"Cams/Cam UI/Camera buttons"
onready var cam_text = $"Cams/Cam UI/Cam text"
onready var cam_feed = $"Cams/Camera feed"
onready var cam_disabled = $"Cams/Cam UI/Cam disabled audio only"
onready var cam_scrolling = $"UI/Camera Scrolling"
onready var kitchen_cam = $"Cams/Cam UI/Kitchen"
onready var freddy_AI = $"Cams/Cam UI/Freddy"
onready var bonnie_AI = $"Cams/Cam UI/Bonnie"
onready var chica_AI = $"Cams/Cam UI/Chica"
onready var foxy_AI = $"Cams/Cam UI/Foxy"
onready var freddy_radar = $"Cams/Cam UI/Freddy/Sprite"
onready var bonnie_radar = $"Cams/Cam UI/Bonnie/Sprite"
onready var chica_radar = $"Cams/Cam UI/Chica/Sprite"
onready var foxy_radar = $"Cams/Cam UI/Foxy/Sprite"
onready var signal_cut = $"Cams/Cam UI/Signal Cut"
onready var signal_timer = $"Cams/Cam UI/Signal Cut/Timer"
onready var foxy_countdown = $"Foxy Countdown"
onready var fan_sound = $"Background/Fan/Fan buzzing"
onready var cam_sound = $"Cams/Camera feed/AudioStreamPlayer"
onready var light_buzzing = $"Light sound"
onready var signal_cut_sound = $"Cams/Cam UI/Signal Cut/Garble"
onready var garble_1 = load("res://FNaF 1/FNaF 1 Audio/garble1.wav")
onready var garle_2 = load("res://FNaF 1/FNaF 1 Audio/garble2.wav")
onready var garble_3 = load("res://FNaF 1/FNaF 1 Audio/garble3.wav")
onready var pots_and_pans = $"Cams/Camera feed/Kitchen sound"
onready var kitchen_sound_1 = load("res://FNaF 1/FNaF 1 Audio/OVEN-DRAWE_GEN-HDF18122.wav")
onready var kitchen_sound_2 = load("res://FNaF 1/FNaF 1 Audio/OVEN-DRA_1_GEN-HDF18119.wav")
onready var kitchen_sound_3 = load("res://FNaF 1/FNaF 1 Audio/OVEN-DRA_2_GEN-HDF18120.wav")
onready var kitchen_sound_4 = load("res://FNaF 1/FNaF 1 Audio/OVEN-DRA_7_GEN-HDF18121.wav")
onready var Freddy_music_box = $"Freddy Music Box"
onready var Freddy_song = load("res://FNaF 1/FNaF 1 Audio/music box.wav")
onready var powerout_sound = $"Power Outage"
#Defining the nodes used in the script

var light_L = false
var light_R = false
var light_flicker = 0
var rng = RandomNumberGenerator.new()
var usage = 1
var data
var Freddy_appears = false
var power_left = 99
var time = 12
var cam = 1
var bonnie_pos = 1
var chica_pos = 1
var freddy_attack = false
var freddy_jumpscare = false
var bonnie_attack = false
var bonnie_jumpscare = false
var chica_attack = false
var chica_jumpscare = false
var foxy_attack = false
var foxy_jumpscare = false
var power_steal = 0
var foxy_on_his_way = false
var what_garble = 0
var chica_moving_in_kitchen
#defining variables

func _ready():
	var file = File.new()
	if file.file_exists(NightSaving.Save_Path):
		var error = file.open(NightSaving.Save_Path, File.READ)
		if error == OK:
			data = file.get_var()
			file.close()
	
	power_out_flicker.visible = false
	power_anim.play("Default")
	night_text.text = String(data["Night"])
	cam_map.play("Final")

func _physics_process(delta):
	cam = cam_buttons.cam
	
	if power_left > 0:
		time_label.text = String(time)
	
	if monitor.status != 2 and bonnie_jumpscare == false:
		camera.position = get_local_mouse_position()
	else:
		camera.position = camera.position.linear_interpolate(cam_scrolling.scrolling.position, delta)
	#making the camera follow the mouse
	
	if NightSaving.infinite_power == false:
		power_left = power.power
	
	if power_left > 0 and bonnie_jumpscare == false and chica_jumpscare == false and foxy_jumpscare == false and freddy_jumpscare == false:
		lights()
		usage()
		power_drainage()
		freddy_position()
		bonnie_position()
		chica_position()
		foxy_position()
		freddy_jumpscare()
		bonnie_jumpscare()
		chica_jumpscare()
		foxy_jumpscare()
	
	elif power_left == 0:
		power_outage()
	
	if Freddy_appears == true:
		Freddy_power_scare()

	if monitor.status == 2:
		cam_UI.visible = true
		cam_sound.playing = true
	else:
		cam_UI.visible = false
		cam_sound.playing = false
	
	if monitor.status == 2 and NightSaving.radar == true:
		freddy_AI.visible = true
		bonnie_AI.visible = true
		chica_AI.visible = true
		foxy_AI.visible = true

	camera_text()
	camera_feed()
	
	if monitor.status == 2:
		foxy_AI.blocked = true
		fan_sound.set_volume_db(-9)
	
	if monitor.status != 2:
		fan_sound.set_volume_db(-2)
	if foxy_AI.map_position == 4 and foxy_on_his_way == false:
		foxy_countdown.start()
		foxy_on_his_way = true
	if NightSaving.old_cameras == true:
		match cam:
			1: cam_map.play("Cam 1 a")
			2: cam_map.play("Cam 1 b")
			3: cam_map.play("Cam 1 c")
			4: cam_map.play("Cam 2 A")
			5: cam_map.play("Cam 2 B")
			6: cam_map.play("Cam 3")
			7: cam_map.play("Cam 4 A")
			8: cam_map.play("Cam 4 B")
			9: cam_map.play("Cam 5")
			10: cam_map.play("Cam 6")
			11: cam_map.play("Cam 7")
	else:
		cam_map.play("Final")
#calling all functions that need to be constantly running

func on_left_light_pressed():
	if door_button_L.light_pressed == false and door_button_R.light_pressed == false and door_button_L.jammed == false:
		usage += 1
	elif door_button_L.light_pressed == true and door_button_L.jammed == false:
		usage -=1
	else:
		door_button_R.light_pressed = false

func on_right_light_pressed():
	if door_button_R.light_pressed == false and door_button_L.light_pressed == false and door_button_R.jammed == false:
		usage += 1
	elif door_button_R.light_pressed == true and door_button_R.jammed == false:
		usage -=1
	else:
		door_button_L.light_pressed = false
#The lights turn off the oposite light if it's left on when turning on

func lights():
	if door_button_L.jammed == false:
		light_L = door_button_L.light_pressed
	else:
		light_L = false
	
	if door_button_R.jammed == false:
		light_R = door_button_R.light_pressed
	else:
		light_R = false

	match [light_L, light_R, light_flicker]:
		[false, false, 0]: 
			office.play("default")
			light_buzzing.stop()
		[true, false, 0]:
			office.play("default")
			light_buzzing.stop()
		[true, false, 1]: 
			if bonnie_AI.map_position == 7:
				office.play("Bonnie in office")
			elif bonnie_AI.map_position != 7:
				office.play("Left Light")
			light_buzzing.play()
		[false, true, 0]: 
			office.play("default")
			light_buzzing.stop()
		[false, true, 1]: 
			if chica_AI.map_position == 7:
				office.play("Chica in office")
			else:
				office.play("Right Light")
			light_buzzing.play()
	
	if light_L == true:
		match light_flicker:
			true: light_buzzing.playing = false
			false: light_buzzing.playing = true
	elif light_R == true:
		match light_flicker:
			true: light_buzzing.playing = true
			false: light_buzzing.playing = false
	elif light_L == false and light_R == false:
		light_buzzing.playing = false
	
	if door_button_L.jammed == true and light_L == true:
		usage -= 1
	
	if door_button_R.jammed == true and light_R == true:
		usage -= 1
#Showing the lights on screen depending on what light is on and how the light is flickering


func _on_Light_flicker_timer_timeout():
	rng.randomize()
	light_flicker = rng.randi_range(0, 1)
#Making the light flicker

func usage():
	match usage:
		1: usage_bar.play("One")
		2: usage_bar.play("Two")
		3: usage_bar.play("Three")
		4: usage_bar.play("Four")
		5: usage_bar.play("Five")


func on_left_door_pressed():
	if door_button_L.door_pressed == false and door_button_L.jammed == false:
		usage += 1
		door_L.status = 1
	elif door_button_L.jammed == false:
		usage -= 1
		door_L.status = 2
	else:
		door_L.status = 0

func on_right_door_pressed():
	if door_button_R.door_pressed == false and door_button_R.jammed == false:
		usage += 1
		door_R.status = 1
	elif door_button_R.jammed == false:
		usage -= 1
		door_R.status = 2
	else:
		door_R.status = 0
#Making the doors use power

func power_drainage():
	match [usage, data["Night"]]:
		[1, 1]: power_timer.wait_time = 7
		[2, 1]: power_timer.wait_time = 6
		[3, 1]: power_timer.wait_time = 5
		[4, 1]: power_timer.wait_time = 4
		[1, 2]: power_timer.wait_time = 7
		[2, 2]: power_timer.wait_time = 6
		[3, 2]: power_timer.wait_time = 5
		[4, 2]: power_timer.wait_time = 4
		[1, 3]: power_timer.wait_time = 6
		[2, 3]: power_timer.wait_time = 5
		[3, 3]: power_timer.wait_time = 4
		[4, 3]: power_timer.wait_time = 3
		[1, 4]: power_timer.wait_time = 5
		[2, 4]: power_timer.wait_time = 4
		[3, 4]: power_timer.wait_time = 3
		[4, 4]: power_timer.wait_time = 2
		[1, 5]: power_timer.wait_time = 4
		[2, 5]: power_timer.wait_time = 3
		[3, 5]: power_timer.wait_time = 2
		[4, 5]: power_timer.wait_time = 1
#Making the power drain

func power_outage():
	rng.randomize()
	powerout_timer.wait_time = rng.randi_range(1, 20)
	powerout_timer.start()
	powerout_sound.play()
	office.play("Power outage")
	
	fan.queue_free()
	door_button_L.queue_free()
	door_button_R.queue_free()
	UI.queue_free()
	cam_parent.queue_free()
	
	if door_L.status == 1:
		door_L.status = 2
	if door_R.status == 1:
		door_R.status = 2
	
	power_left = -1
#Making power go out

func _on_Power_Outage_Timer_timeout():
	Freddy_appears = true
	rng.randomize()
	Freddy_duration.wait_time = rng.randi_range(1, 20)
	Freddy_duration.start()
#Making Freddy's appearance random

func Freddy_power_scare():
	Freddy_music_box.play()
	
	match light_flicker:
		0: office.play("Power outage")
		1: office.play("Power Outage Freddy")
	
	Freddy_music_box.play()
#Making Freddy appear when the power runs out

func _on_Freddy_Duration_timeout():
	Freddy_music_box.stop()
	Freddy_appears = false
	power_out_flicker.visible = true
	power_anim.play("Flicker")
	Freddy_music_box.stop()
	rng.randomize()
	scare_timer_powerout.wait_time = rng.randi_range(0, 20)
	scare_timer_powerout.start()
#Making the office go dark after Freddy's music box is done playing


func _on_Scaretimer_powerout_timeout():
	get_tree().change_scene("res://Jumpscares/Assets/Freddy Jumpscare.tscn")
	#Getting Freddy to jumpscare you


func _on_Night_timer_timeout():
	if time == 12:
		time = 1
	else:
		time += 1
	
	if time == 6:
		get_tree().change_scene("res://6 AM Screen/Assets/6 AM Screen.tscn")
	match time:
		1: 
			bonnie_AI.AI += 1
		2: 
			bonnie_AI.AI += 1
			chica_AI.AI += 1
			foxy_AI.AI += 1
		3: 
			bonnie_AI.AI += 1
			chica_AI.AI += 1
			foxy_AI.AI += 1
#Making time pass and switching to the 6 am screen


func _on_Camera_Trigger_mouse_entered():
	if monitor.status == 0 and door_button_L.light_pressed == false and door_button_R.light_pressed == false:
		usage += 1
	elif door_button_L.light_pressed == true or door_button_R.light_pressed == true:
		light_L = 0
		door_button_L.light_pressed = false
		light_R = 0
		door_button_R.light_pressed = false
	elif monitor.status == 2:
		usage -= 1
		rng.randomize()
		foxy_AI.block_timer.wait_time = rng.randf_range(0.83, 16.67)
		foxy_AI.block_timer.start()
#Making the camera drain power

func camera_text():
	match cam:
		1: cam_text.play("Show stage")
		2: cam_text.play("Dining Area")
		3: cam_text.play("Pirate Cove")
		4: cam_text.play("West Hall")
		5: cam_text.play("West Hall Corner")
		6: cam_text.play("Supply Closet")
		7: cam_text.play("East Hall")
		8: cam_text.play("East Hall Corner")
		9: cam_text.play("Backstage")
		10: cam_text.play("Kitchen")
		11: cam_text.play("Bathrooms")
#Making the camera show the appropriate text

func camera_feed():
	match cam:
		1: 
			if bonnie_AI.map_position == 1 and chica_AI.map_position == 1 and freddy_AI.map_position == 1:
				cam_feed.play("Show Stage")
			elif bonnie_AI.map_position != 1 and chica_AI.map_position == 1 and freddy_AI.map_position == 1:
				cam_feed.play("Stage Bonnie Gone")
			elif bonnie_AI.map_position == 1 and chica_AI.map_position != 1 and freddy_AI.map_position == 1:
				cam_feed.play("Stage chica gone")
			elif bonnie_AI.map_position != 1 and chica_AI.map_position != 1 and freddy_AI.map_position == 1:
				cam_feed.play("Show Stage Only Freddy")
			elif freddy_AI.map_position != 1:
				cam_feed.play("Show Stage Empty")
		2: 
			if bonnie_AI.map_position != 2 and chica_AI.map_position != 2 and freddy_AI.map_position != 2:
				cam_feed.play("Dining Area")
			elif bonnie_AI.map_position == 2 and bonnie_pos == 1:
				cam_feed.play("Bonnie dining 1")
			elif bonnie_AI.map_position == 2 and bonnie_pos == 2:
				cam_feed.play("Bonnie dining 2")
			elif chica_AI.map_position == 2 and chica_pos == 1:
				cam_feed.play("Chica Dining 1")
			elif chica_AI.map_position == 2 and chica_pos == 2:
				cam_feed.play("Chica Dining 2")
			elif freddy_AI.map_position ==2:
				cam_feed.play("Freddy Dining Area")
		3: 
			if foxy_AI.map_position == 1:
				cam_feed.play("Pirate Cove")
			elif foxy_AI.map_position == 2:
				cam_feed.play("Foxy peeking")
			elif foxy_AI.map_position == 3:
				cam_feed.play("Foxy on his way")
			elif foxy_AI.map_position == 4:
				match foxy_AI.its_me:
					0: cam_feed.play("Foxy gone")
					1: cam_feed.play("Foxy Gone It's me")
		5: 
			if bonnie_AI.map_position !=6:
				cam_feed.play("West Hall Corner")
			elif bonnie_AI.map_position == 6:
				cam_feed.play("Bonnie Corner")
		6: 
			if bonnie_AI.map_position !=5:
				cam_feed.play("Supply Closet")
			elif bonnie_AI.map_position == 5:
				cam_feed.play("Bonnie Supply Closet")
		7: 
			if chica_AI.map_position != 5 and freddy_AI.map_position != 5:
				cam_feed.play("East Hall")
			elif chica_AI.map_position == 5 and chica_pos == 1:
				cam_feed.play("Chica Hallway 1")
			elif chica_AI.map_position == 5 and chica_pos == 2:
				cam_feed.play("Chica Hallway 2")
			elif freddy_AI.map_position == 5:
				cam_feed.play("Freddy Hall")
		8: 
			if chica_AI.map_position != 6 and freddy_AI.map_position != 6:
				cam_feed.play("East Hall Corner")
			elif chica_AI.map_position == 6:
				cam_feed.play("Chica Corner")
			elif freddy_AI.map_position == 6:
				cam_feed.play("Freddy Corner")
		9: 
			if bonnie_AI.map_position != 3:
				cam_feed.play("Backstage")
			elif bonnie_AI.map_position == 3 and bonnie_pos == 1:
				cam_feed.play("Backstage Bonnie 1")
			elif bonnie_AI.map_position == 3 and bonnie_pos == 2:
				cam_feed.play("Backstage Bonnie 2")
		10: 
			cam_feed.play("Kitchen")
			if chica_AI.map_position == 4 and monitor.status == 2:
				rng.randomize()
				chica_moving_in_kitchen = rng.randi_range(1, 4)
				match chica_moving_in_kitchen:
					1: pots_and_pans.stream = kitchen_sound_1
					2: pots_and_pans.stream = kitchen_sound_2
					3: pots_and_pans.stream = kitchen_sound_3
					4: pots_and_pans.stream = kitchen_sound_4
				pots_and_pans.play()
			elif freddy_AI.map_position == 4 and monitor.status == 2:
				pots_and_pans.stream = Freddy_song
				pots_and_pans.play()
			else:
				pots_and_pans.stop()
		11:
			if chica_AI.map_position != 3 and freddy_AI.map_position != 3:
				cam_feed.play("Restrooms")
			elif chica_AI.map_position == 3:
				cam_feed.play("Chica Restrooms")
			elif freddy_AI.map_position == 3:
				cam_feed.play("Freddy Restrooms")

	if foxy_AI.map_position != 4:
		match [cam, light_flicker]:
			[4, 0]: cam_feed.play("West Hall")
			[4, 1]:
				if bonnie_AI.map_position != 4:
					cam_feed.play("West Hall Light On")
				elif bonnie_AI.map_position == 4:
					cam_feed.play("Bonnie Hallway")
	elif cam_feed.animation != "Foxy Running":
		match cam:
			4: cam_feed.play("Foxy Running")

	if monitor.status == 2:
		cam_feed.visible = true
	else:
		cam_feed.visible = false
		
	if cam == 10 and monitor.status == 2:
		cam_disabled.visible = true
		kitchen_cam.visible = true
	else:
		cam_disabled.visible = false
		kitchen_cam.visible = false
#Making the cameras show the camera feed

func bonnie_position():
	match bonnie_AI.map_position:
		1: bonnie_radar.global_position = cam_buttons.cam_1_a.global_position
		2: bonnie_radar.global_position = cam_buttons.cam_1_b.global_position
		3: bonnie_radar.global_position = cam_buttons.cam_5.global_position
		4: bonnie_radar.global_position = cam_buttons.cam_2_a.global_position
		5: bonnie_radar.global_position = cam_buttons.cam_3.global_position
		6: bonnie_radar.global_position = cam_buttons.cam_2_b.global_position
#moving bonnie across cameras
func chica_position():
	match chica_AI.map_position:
		1: chica_radar.global_position = cam_buttons.cam_1_a.global_position
		2: chica_radar.global_position = cam_buttons.cam_1_b.global_position
		3: chica_radar.global_position = cam_buttons.cam_7.global_position
		4: chica_radar.global_position = cam_buttons.cam_6.global_position
		5: chica_radar.global_position = cam_buttons.cam_4_a.global_position
		6: chica_radar.global_position = cam_buttons.cam_4_b.global_position

func foxy_position():
	if foxy_AI.map_position == 4:
		foxy_radar.global_position = cam_buttons.cam_2_a.global_position
	else:
		foxy_radar.global_position = cam_buttons.cam_1_c.global_position

func _on_bonnie_movement():
	if bonnie_AI.AI >= bonnie_AI.movement_opportunity and bonnie_AI.map_position <= 6:
		signal_cut.visible = true
		signal_timer.start()
		rng.randomize()
		what_garble = rng.randi_range(1, 3)
		match what_garble:
			1: signal_cut_sound.stream = garble_1
			2: signal_cut_sound.stream = garle_2
			3: signal_cut_sound.stream = garble_3
		signal_cut_sound.play()
	elif bonnie_AI.AI >= bonnie_AI.movement_opportunity and bonnie_AI.map_position == 7:
		bonnie_attack = true
	
	rng.randomize()
	bonnie_pos = rng.randi_range(1, 2)
#cutting signal when bonnie moves

func _on_signal_working_again():
	signal_cut.visible = false
#making signal come back

func bonnie_jumpscare():
	if door_L.status == 1 and bonnie_attack == true:
		bonnie_attack = false
		bonnie_AI.map_position = 2
	elif door_L.status == 0 and bonnie_attack == true:
		door_button_L.jammed = true
	
	if monitor.status == 2 and door_button_L.jammed == true and bonnie_jumpscare == false:
		bonnie_jumpscare = true
	
	if bonnie_jumpscare == true:
		if office.animation != "Bonnie_Jumpscare":
			office.play("Bonnie Jumpscare")
		monitor.monitor.play("Cam Down")
		monitor.status = 0
		UI.visible = false
		door_L.visible = false
		door_R.visible = false
		door_button_L.visible = false
		door_button_R.visible = false
		fan.visible = false
#Making bonnie attack at the door

func _on_Background_animation_finished():
	if office.animation == "Bonnie Jumpscare":
		get_tree().change_scene("res://Game Over/Assets/Game Over Static.tscn")
	elif office.animation == "Chica Jumpscare":
		get_tree().change_scene("res://Game Over/Assets/Game Over Static.tscn")
	elif office.animation == "Foxy Jumpscare":
		get_tree().change_scene("res://Game Over/Assets/Game Over Static.tscn")
	elif office.animation == "Freddy Jumpscare":
		get_tree().change_scene("res://Game Over/Assets/Game Over Static.tscn")
#making the jumpscares show the game over screen

func _on_chica_movement():
	if chica_AI.AI >= chica_AI.movement_opportunity and chica_AI.map_position <= 6:
		signal_cut.visible = true
		signal_timer.start()
		rng.randomize()
		what_garble = rng.randi_range(1, 3)
		match what_garble:
			1: signal_cut_sound.stream = garble_1
			2: signal_cut_sound.stream = garle_2
			3: signal_cut_sound.stream = garble_3
		signal_cut_sound.play()
	elif chica_AI.AI >= chica_AI.movement_opportunity and chica_AI.map_position == 7:
		chica_attack = true
	
	rng.randomize()
	chica_pos = rng.randi_range(1, 2)


func chica_jumpscare():
	if door_R.status == 1 and chica_attack == true:
		chica_attack = false
		chica_AI.map_position = 2
	elif door_R.status == 0 and chica_attack == true:
		door_button_R.jammed = true
	
	if monitor.status == 2 and door_button_R.jammed == true and chica_jumpscare == false:
		chica_jumpscare = true
	
	if chica_jumpscare == true:
		if office.animation != "Chica Jumpscare":
			office.play("Chica Jumpscare")
		monitor.monitor.play("Cam Down")
		monitor.status = 0
		UI.visible = false
		door_L.visible = false
		door_R.visible = false
		door_button_L.visible = false
		door_button_R.visible = false
		fan.visible = false
#Making Chica attack at the door

func foxy_jumpscare():
	if door_L.status == 1 and foxy_attack == true:
		foxy_AI.map_position = rng.randi_range(1, 2)
		foxy_attack = false
		power_steal += 1
		if power_steal == 1:
			power_left-= 1
		elif power_steal == 2:
			 power_left -= 6
		else: 
			power_left -= 5 * power_steal +1
	elif door_L.status == 0 and foxy_attack == true and foxy_jumpscare == false:
		foxy_jumpscare = true
	
	if foxy_jumpscare == true:
		if office.animation != "Foxy Jumpscare":
			office.play("Foxy Jumpscare")

func _on_Camera_feed_animation_finished():
	if cam_feed.animation == "Foxy Running":
		foxy_attack = true

func _on_Foxy_Countdown_timeout():
	if foxy_AI.map_position == 4 and foxy_attack == false:
		foxy_attack = true
		foxy_on_his_way = false

func freddy_position():
	if bonnie_AI.map_position == 1 or chica_AI.map_position == 1:
		freddy_AI.locked = true
	else:
		match freddy_AI.map_position:
			1: 
				if cam == 1:
					freddy_AI.locked = true
				else:
					freddy_AI.locked = false
			2: 
				if cam == 2:
					freddy_AI.locked = true
				else:
					freddy_AI.locked = false
			3: 
				if cam == 11:
					freddy_AI.locked = true
				else:
					freddy_AI.locked = false
			4:
				if cam == 10:
					freddy_AI.locked = true
				else:
					freddy_AI.locked = false
			5:
				if cam == 7:
					freddy_AI.locked = true
				else:
					freddy_AI.locked = false
			6:
				if cam == 8:
					freddy_AI.locked = true
				else: 
					freddy_AI.locked = false
	
	match freddy_AI.map_position:
		1: freddy_radar.global_position = cam_buttons.cam_1_a.global_position
		2: freddy_radar.global_position = cam_buttons.cam_1_b.global_position
		3: freddy_radar.global_position = cam_buttons.cam_7.global_position
		4: freddy_radar.global_position = cam_buttons.cam_6.global_position
		5: freddy_radar.global_position = cam_buttons.cam_4_a.global_position
		6: freddy_radar.global_position = cam_buttons.cam_4_b.global_position

func _on_freddy_movement():
	if freddy_AI.AI >= freddy_AI.movement_opportunity and freddy_AI.map_position > 1 and freddy_AI.map_position < 6 and freddy_AI.locked == false:
		signal_cut.visible = true
		signal_timer.start()
		rng.randomize()
		what_garble = rng.randi_range(1, 3)
		match what_garble:
			1: signal_cut_sound.stream = garble_1
			2: signal_cut_sound.stream = garle_2
			3: signal_cut_sound.stream = garble_3
		signal_cut_sound.play()
	elif freddy_AI.AI >= freddy_AI.movement_opportunity and freddy_AI.map_position == 6 and freddy_AI.locked == false:
		freddy_attack = true

func freddy_jumpscare():
	freddy_jumpscare = freddy_AI.jumpscare
	
	if door_R.status == 1 and freddy_attack == true:
		freddy_attack == false
		freddy_AI.map_position = 5
	elif door_R.status == 0 and freddy_attack == true:
		freddy_AI.map_position == 7
		freddy_AI.scare_timer.start()
		rng.randomize()
		freddy_AI.scare_timer.wait_time = rng.randi_range(1, 20)
		freddy_attack = false
	
	if freddy_jumpscare == true:
		office.play("Freddy Jumpscare")
		if monitor.status == 2:
			monitor.monitor.play("Cam Down")
		monitor.status = 0
		UI.visible = false
		door_L.visible = false
		door_R.visible = false
		door_button_L.visible = false
		door_button_R.visible = false
		fan.visible = false
