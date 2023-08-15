extends RigidBody2D

const SPEED = 50.0



var spawn_position = position

#possibly confusingly, the higher then number, the slower it turns (maybe i should come up with a better variable name)
var turn_speed = 1.0

#toggles depending on if the player is in the Area2D
var observe = false

#vector on where the civilian is looking
var look_direction = Vector2.ZERO

func _physics_process(delta):
	#delta but times 60 because _physics_process happesn 60 times a second
	var relevantDelta = delta * 60.0
	
	
	#makes look_direction basically point towards the player's position relative to the civilian...
	#that is if observe = true
	if observe:
		look_direction = Vector2($/root/Main/Player.position.x - position.x, $/root/Main/Player.position.y - position.y)
	
	
	#turn towards the direction of movement
	var angle_diff = 0.0 
	var rotation_vector = Vector2(cos(rotation), sin(rotation))
	
	angle_diff = rotation_vector.angle_to(look_direction)
	angular_velocity += angle_diff / turn_speed * relevantDelta

#these two functions actually do the toggling of the 'observe' variable
func _on_area_2d_body_entered(body):
	if "player" in body:
		observe = true
		if body.rage_level >= 1 and body.rage_level < 2:
			


func _on_area_2d_body_exited(body):
	if "player" in body:
		observe = false
