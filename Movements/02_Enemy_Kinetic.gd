@export var speed : float = 6.75
var target_position : Vector2i = Vector2(0,0)
var arrival_threshold : float = 5


func _physics_process(_delta):
	match current_states:
		States.IDLE:
			pass
		States.WALKING:
			move_to(target_position,_delta,States.WORKING)
		States.WORKING:
			working(_delta)
		States.ADJUST:
			move_to(target_position,_delta,States.IDLE)
	return

func move_to(target:Vector2,_delta:float,END_STATE:int):
	# Check if we have reached the target
	if (target - position).length() < arrival_threshold:
		change_state(END_STATE) # Change_to_WORKING	
		return

	# Get velocity as unit vector
	var velocity = (target - position).normalized()
	
	# Steer the body of zombie to the velocity
	body.rotation = lerp_angle(body.rotation,velocity.angle(),0.2)
	
	# Update position
	position += velocity * speed
	return
