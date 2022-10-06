extends Node2D

onready var scrolling = $KinematicBody2D

var speed = 50
var velocity = Vector2(1, 0)

func _physics_process(delta):
	scrolling.move_and_slide(velocity * speed)


func _on_Left_Limit_body_entered(body):
	velocity.x = 1


func _on_Right_Limit_body_entered(body):
	velocity.x = -1
