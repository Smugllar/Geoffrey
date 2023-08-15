extends CanvasLayer

var in_game = true

var playerNode = String()

# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	playerNode = get_tree().get_nodes_in_group("player")[0]
	if in_game and playerNode != null:
		$faces.play()
		if playerNode.rage_level < 1:
			$faces.animation = "normal"
		elif playerNode.rage_level < 2:
			$faces.animation = "slight"
		else:
			$faces.animation = "crazy"
		
		$TextureProgressBar.value = playerNode.rage_level
