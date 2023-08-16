extends RigidBody2D

var rotation_diff = 0.0
var rotation_speed = 2.0
var playerNode
# Called when the node enters the scene tree for the first time.
func _ready():
	set_contact_monitor(true)
	set_max_contacts_reported(2)
	playerNode = get_tree().get_nodes_in_group("player")[0]
	



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	var relevantDelta = delta * 60
	#makes the pan always try to be upright
	rotation_diff = 0 - rotation
	angular_velocity += (rotation_diff / rotation_speed) * relevantDelta

func bruh():
	queue_free()
