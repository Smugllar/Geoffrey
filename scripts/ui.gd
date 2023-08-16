extends CanvasLayer

signal level_1()
signal level_2()
signal level_3()
signal level_4()
signal level_5()

var in_game = false

var playerNode = String()

var move_dir = Vector2(randi_range(-50, 50), randi_range(-50, 50))

# Called when the node enters the scene tree for the first time.
func _ready():
	$guy.position = Vector2(randi_range(-300, 300), randi_range(-100, 100))
	$guy.rotation = randi_range(0, 2 * PI)
	$Message.hide()
	$guy/PositionTimer.start()
	$guy/PositionTimer.set_wait_time(0)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	#showing and hiding the ui
	if in_game:
		$guy.hide()
		$Geoffrey.hide()
		$LevelContainer.hide()
		$faces.show()
		$hotbar.show()
		$RageMeter.show()
	else:
		$guy.show()
		$Geoffrey.show()
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
	else:
		$guy.position += move_dir.normalized() / 4


func _on_level_1_pressed():
	level_1.emit()
	$Message.show()
	$Message.text = "LEVEL 1"
	$Message/MessageTimer.start()


func _on_message_timer_timeout():
	$Message.hide()


func _on_position_timer_timeout():
	$guy.position = Vector2(randi_range(100, 700), randi_range(100, 300))
	$guy.rotation = randi_range(0, 2 * PI)
	move_dir = Vector2(randi_range(-50, 50), randi_range(-50, 50))

func reset():
	$Message.show()
	$Message.text = "YOU SUCK!!"
	$Message/MessageTimer.start()
	await get_tree().create_timer(3.0).timeout
	in_game = false
