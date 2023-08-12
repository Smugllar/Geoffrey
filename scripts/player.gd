extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -400.0

var move


func _physics_process(delta):
	
	#left righgt movement2!!!
	var direction = Input.get_axis("move_left", "move_right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x *= 0.9

	#up down omventment!!!!!!
	direction = Input.get_axis("move_up", "move_down")
	if direction:
		velocity.y = direction * SPEED
	else:
		velocity.y *= 0.9

	move_and_slide()
