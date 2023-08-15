extends CanvasLayer

signal level_1()
signal level_2()
signal level_3()
signal level_4()
signal level_5()

var in_game = false

var playerNode = String()

# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	#showing and hiding the ui
	if in_game:
		$LevelContainer.hide()
		$faces.show()
		$hotbar.show()
		$RageMeter.show()
	else:
		$LevelContainer.show()
		$faces.hide()
		$hotbar.hide()
		$RageMeter.hide()
	
	if in_game:
		if len(get_tree().get_nodes_in_group("player")) > 0:
			playerNode = get_tree().get_nodes_in_group("player")[0]
			if in_game and playerNode != null:
				$faces.play()
				if playerNode.rage_level < 1:
					$faces.animation = "normal"
				elif playerNode.rage_level < 2:
					$faces.animation = "slight"
				else:
					$faces.animation = "crazy"
				
				$RageMeter.value = playerNode.rage_level


func _on_level_1_pressed():
	level_1.emit()
