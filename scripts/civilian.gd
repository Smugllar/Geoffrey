extends RigidBody2D

signal died()

const SPEED = 50.0

#possibly confusingly, the higher then number, the slower it turns (maybe i should come up with a better variable name)
var turn_speed = 1.0

#toggles depending on if the player is in the Area2D
var observe = false

#vector on where the civilian is looking
var look_direction = Vector2.ZERO

var move_dir = Vector2()
var scared = false
var go_home = false
var alive = true

var spawn_position = Vector2()

var playerNode = String()

func _ready():
	playerNode = get_tree().get_nodes_in_group("player")[0]
	spawn_position = position
	$AnimatedSprite2D.play()

func _physics_process(delta):
	if playerNode == null:
		print('yeah its null')
		playerNode = get_tree().get_nodes_in_group("player")[0]
	#delta but times 60 because _physics_process happesn 60 times a second
	var relevantDelta = delta * 60.0
	
	#all the code regarding if the player gets too close
	#that is if observe = true
	if alive:
		if observe:
			playerNode.rage_level += playerNode.rage_rate * 2 * relevantDelta
			look_direction = playerNode.position - position
			if playerNode.rage_level >= 1 and playerNode.rage_level < 2:
				linear_velocity -= look_direction.normalized() * (SPEED / 3) * relevantDelta
			elif playerNode.rage_level >= 2:
				look_direction *= -1
				linear_velocity += look_direction.normalized() * (SPEED * 1.3) * relevantDelta
		
		
		#goes to spawn position if criteria are met (not afraid, far enough away)
		if go_home and position.distance_to(spawn_position) > 20:
			look_direction = spawn_position - position
			linear_velocity += look_direction.normalized() * SPEED * relevantDelta
		elif position.distance_to(spawn_position) <= 20:
			go_home = false
	
	
	#turn stuff
	var angle_diff = 0.0 
	var rotation_vector = Vector2(cos(rotation), sin(rotation))
	
	angle_diff = rotation_vector.angle_to(look_direction)
	angular_velocity += angle_diff / turn_speed * relevantDelta
	
	
	#basically code that handles death
	if position.distance_to(playerNode.position) <= 80 and playerNode.rage_level >= 2:
		if alive:
			get_tree().call_group("main", "died")
		alive = false
		$hitbox.disabled = true
		died.emit()

	
	
	#animation stuff
	$AnimatedSprite2D.speed_scale = linear_velocity.length() / 100
	if alive:
		if linear_velocity.length() < 0.5:
			$AnimatedSprite2D.animation = "idle"
		else:
			$AnimatedSprite2D.animation = "walk"
	else:
		$AnimatedSprite2D.animation = "dead"

#these two functions actually do the toggling of the 'observe' variable
func _on_area_2d_body_entered(body):
	if "player" in body:
		observe = true
		if playerNode.rage_level >= 1:
			scared = true
		
		if scared:
			go_home = false


func _on_area_2d_body_exited(body):
	if "player" in body:
		observe = false
		$ReturnTimer.start()


func _on_return_timer_timeout():
	if playerNode.rage_level < 2:
		scared = false
	if not observe:
		go_home = true
