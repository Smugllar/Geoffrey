extends CharacterBody2D


const SPEED = 50.0
const JUMP_VELOCITY = -400.0

var move_dir = Vector2()


func _physics_process(delta):
	#delta but times 60 because _physics_process happesn 60 times a second
	var relevantDelta = delta * 60
	
	#for if there is no movemetn!!!
	move_dir = Vector2.ZERO
	
	#gets the direction that the character will be moving soon but in a coordinate sorta way
	var direction = Vector2( Input.get_axis("move_left", "move_right"), Input.get_axis("move_up", "move_down") )
	
	#i transfer the value of direction to a different variable because it soon gets changed
	move_dir = direction
	if move_dir != Vector2.ZERO:
		move_dir = move_dir.normalized()
	
	velocity += move_dir * SPEED * relevantDelta
	velocity *= 0.9
	
	move_and_slide()
