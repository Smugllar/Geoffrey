extends RigidBody2D

const player = true

var speed = 50.0

#possibly confusingly, the higher the number, the slower it turns (maybe i should come up with a better variable name)
var turn_speed = 2.0

var move_dir = Vector2()
var rage_dir = Vector2()
var rage_priority = 0.0
var grabbable = false
var object
var can_move = true

#rage_level is what changes how angry you are (shocker)
var rage_level = 0.0
var rage_rate = 0.0005
var rage_status = 0

func _ready():
	$AnimatedSprite2D.play()

func _physics_process(delta):
	var civilians = get_tree().get_nodes_in_group("civilians")
	#delta but times 60 because _physics_process happesn 60 times a second
	var relevantDelta = delta * 60.0
	
	#deals with the rate at which rage_level rises
	match rage_status:
		0:
			rage_level += rage_rate * relevantDelta
		1:
			rage_level += rage_rate * 5 * relevantDelta
		2:
			rage_level -= rage_rate * 20 * relevantDelta
	
	#for if there is no movemetn!!!
	move_dir = Vector2.ZERO
	
	#deals with the vectors of facing at the nearest civilian
	if len(civilians) > 0:
		var nearest_civilian = civilians[0]
		for civilian in civilians:
			#finds which civilian is closest to the player
			if civilian.position.distance_to(position) < nearest_civilian.position.distance_to(position):
				nearest_civilian = civilian
		rage_dir = nearest_civilian.position - position
		rage_dir = rage_dir.normalized()
	
	#gets the direction that the character will be moving soon but in a coordinate sorta way
	var direction = Vector2( Input.get_axis("move_left", "move_right"), Input.get_axis("move_up", "move_down") )
	
	if rage_level < 1:
		rage_priority = 0.0
		speed = 50.0
		if rage_status != 2:
			rage_status = 0
	elif rage_level < 2:
		rage_priority = randf_range(0.2, 0.4)
		speed = 65.0
		if rage_status != 2:
			rage_status = 0
	elif rage_level < 3:
		rage_priority = 1.0
		speed = 80.0
		if rage_status != 2:
			rage_status = 1
	else:
		rage_status = 2
	
	#reset rage once it goes back to normal
	if rage_level <= 0:
		rage_status = 0
	
	#i transfer the value of direction to a different variable because it soon gets changed
	move_dir = direction
	if move_dir != Vector2.ZERO:
		move_dir = move_dir.normalized()
	
	if can_move:
		linear_velocity += ( (move_dir * (1 - rage_priority) ) + (rage_dir * rage_priority) ) * speed * relevantDelta
	
	#turn towards the direction of movement
	var angle_diff = 0.0 
	var rotation_vector = Vector2(cos(rotation), sin(rotation))
	if linear_velocity:
		angle_diff = rotation_vector.angle_to(linear_velocity)
	
	angular_velocity += angle_diff / turn_speed * relevantDelta
	
	#handles the moving of the grabbable object
	if grabbable:
		if Input.is_action_pressed("grab"):
			var grab_distance = 80
			var grab_spot = position + Vector2(cos(rotation) * grab_distance, sin(rotation) * grab_distance)
			var move_vect = grab_spot - object.position
			object.linear_velocity += move_vect
	
	
	#animations
	$AnimatedSprite2D.speed_scale = linear_velocity.length() / 100
	if linear_velocity.length() < 0.5:
		$AnimatedSprite2D.animation = "idle"
	else:
		$AnimatedSprite2D.animation = "walk"



func _on_grab_area_body_entered(body):
	grabbable = true
	object = body


func _on_grab_area_body_exited(_body):
	grabbable = false

func win():
	can_move = false
	
