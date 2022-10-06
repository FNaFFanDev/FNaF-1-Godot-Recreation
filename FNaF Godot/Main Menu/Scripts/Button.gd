extends Area2D

onready var hitbox = $Hitbox
onready var arrow = $Arrow
onready var blip = $Blip
#Declaring arrow and button's hitbox

func _on_Button_mouse_entered():
	arrow.visible = true
	blip.play()

func _on_Button_mouse_exited():
	arrow.visible = false


#Making it so that the arrow is shown when the mouse is on the button and hidden if it's not.

