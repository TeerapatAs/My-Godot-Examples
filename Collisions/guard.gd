extends CharacterBody2D

""" Guard's Player Detection"""
@onready var is_player_in : bool = false
@onready var player_body : Node2D = null
@onready var ray_cast: RayCast2D = %RayCast2D
@onready var collision_polygon_2d: CollisionPolygon2D = %CollisionPolygon2D



""" Guard State machine """
enum States {PATROL, PURSUIT, WANDER}
@onready var current_state : int = States.PATROL
@onready var label: Label = %Label


""" Guard's movement"""
@onready var navigation_agent_2d: NavigationAgent2D = %NavigationAgent2D
const arrival_threshold : float = 10.0
@onready var wander_new_rotate_timer : int = 0
@onready var random_rotation : float = 0
@onready var wander_radius : float = 135.0
@onready var last_point_player_seen :Vector2 = global_position: # Update when Guard or CCTV detects Player. 
	set(new_pos):
		# Ignore if new_pos is the same or set as 0.
		if new_pos == last_point_player_seen or new_pos == Vector2(0,0):
			return
		# If new_pos is an update, make guard wander that positon!
		# print(last_point_player_seen)
		last_point_player_seen = new_pos
		navigation_agent_2d.target_position = last_point_player_seen
		current_state = States.PURSUIT
@onready var random_wander_target:Vector2 = Vector2(0,0)
@onready var wander_timer : float = 0
@onready var initRotate : float = 0  # Rotation (Rad) at the start.
var count = 0
var SPEED = 120.0
var WANDER_SPEED = 60.0

# PATROL
@onready var patrol_points : Array[Vector2] = [Vector2(0,0)]
var pa_index : int = 0

# Get caught
signal get_caught

func _ready():
	initRotate = rotation
	return
	
func set_speed(new_speed : float):
	SPEED = new_speed

func set_detection_off():
	collision_polygon_2d.set_deferred("disabled", true)

func _process(_delta: float) -> void:
	check_line_sight()
	state_machine()
	move_and_slide()
	label.text = States.find_key(current_state)
	
func state_machine():
	match current_state:
		States.PATROL:
			self.modulate = Color.AQUA
			patrol()
		States.PURSUIT:
			self.modulate = Color.RED
			move_path(last_point_player_seen,SPEED)
			#move_to(last_point_player_seen,SPEED)
		States.WANDER:
			# Set new Timer wander before
			wander_timer = randi_range(240,350)
			self.modulate = Color.YELLOW
			wander()

func patrol():
	var s = patrol_points.size()
	var patrol_pos = patrol_points[pa_index%s]
	if s==1:
		if global_position.distance_to(patrol_pos) < arrival_threshold:
			# IF it close enough no need to update path
			velocity = Vector2(0,0)
			rotation = initRotate
			return
	move_path(patrol_pos,WANDER_SPEED)
	return
	
func set_patrol_pts(array):
	patrol_points = array

func spin_like_round(delta:float):
	var spin_velo : float = 35.0
	rotation += spin_velo * delta

func move_path(target_pos:Vector2,speed:float):
	if navigation_agent_2d.target_position != target_pos:
		navigation_agent_2d.target_position = target_pos
	
	if navigation_agent_2d.is_navigation_finished():
		velocity = Vector2.ZERO
		if player_body:
			get_caught.emit()
		else:
			if current_state == States.PURSUIT:
				current_state = States.WANDER
			elif current_state == States.PATROL:
				pa_index += 1
				
	var next_point = navigation_agent_2d.get_next_path_position()
	var dir = global_position.direction_to(next_point)
	velocity = dir * speed
	# Steer the body to the velocity
	rotation = lerp_angle(rotation,velocity.angle(),0.1)

func  check_line_sight()-> void:
	if is_player_in:
		# Ray cast
		ray_cast.target_position = to_local(player_body.global_position)
		ray_cast.force_raycast_update()
		
		if ray_cast.is_colliding():
			var collider = ray_cast.get_collider()
			if collider is Player:
				# Pursuit Player
				current_state = States.PURSUIT
				last_point_player_seen = player_body.global_position

func wander():
	""" Random Points Searching,
		Searching Area: Center is [last_point_player_seen] with radius of [wander_radius],
		Each point search time is [wander_new_rotate_timer] and total time is [wander_timer] """
	# Timer reach limit -> New Random Rotate angle
	if wander_new_rotate_timer <= 0:		
		# Random target around the area
		var random_offset = Vector2(
		randf_range(-wander_radius, wander_radius),
		randf_range(-wander_radius, wander_radius)
		)
		# Update Wander target and timer
		random_wander_target = random_offset + last_point_player_seen
		wander_new_rotate_timer = randi_range(30,80)
	
	# Wander Timer reach limit -> New Random Attempt
	if wander_timer <= 0:
		current_state = States.PATROL
		wander_timer = randi_range(240,350)
		
	# Move to wander Target
	move_path(random_wander_target,WANDER_SPEED)
	
	#Update Timer
	wander_new_rotate_timer -= 1
	# TODO: FIX
	wander_timer -= 1
	
func _on_area_2d_body_entered(body: Node2D) -> void:
	if body is Player:
		is_player_in = true
		player_body = body

func _on_area_2d_body_exited(body: Node2D) -> void:
	if body is Player:
		# Player escape! Change state to wander!
		current_state = States.WANDER
		last_point_player_seen = player_body.global_position
		is_player_in = false
		player_body = null
