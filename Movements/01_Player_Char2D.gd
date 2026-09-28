class_name Player
extends CharacterBody2D


const SPEED = 150.0

# Player interact-----------------------------------------
func _physics_process(_delta):
	get_input()
	move_and_slide()

func get_input():
	# get vector and direction
	var direction:Vector2 = Input.get_vector("move_left","move_right","move_up","move_down")
	velocity = direction*SPEED
	# turn the body to mouse position
	look_at(get_global_mouse_position())