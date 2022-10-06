extends AudioStreamPlayer

var menu_music = load("res://FNaF 1/FNaF 1 Audio/FNaF_1_Remaster_Main_Menu[YtMp3cc.net].mp3")

func play_menu_music():
	if !playing:
		stream = menu_music
		play()

func stop_music():
	stop()
