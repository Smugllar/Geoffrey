extends RigidBody2D


#makes the health scale with how hard it is to push around
var health = mass * 100
var playerNode = String()

# Called when the node enters the scene tree for the first time.
func _ready():
	set_linear_damp(1.0)
	set_angular_damp(1.0)
	set_contact_monitor(true)
	set_max_contacts_reported(10)
	playerNode = get_tree().get_nodes_in_group("player")[0]



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	for body in get_colliding_bodies():
		if body == playerNode and playerNode.rage_level >= 2:
			health -= 1
	
	if health <= 0:
		queue_free()
