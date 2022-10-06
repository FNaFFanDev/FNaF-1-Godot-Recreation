extends Sprite

onready var power_left = $Power
onready var percent = $Sprite
var power

func _ready():
	if NightSaving.infinite_power == true:
		power = "INFINITE"
		percent.visible = false
	else:
		power = 99
		percent.visible = true

func _physics_process(delta):
	power_left.text = String(power)



func _on_Timer_timeout():
		if NightSaving.infinite_power == false:
			power -= 1
