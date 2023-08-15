extends CanvasLayer

var in_game = true

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if in_game:
		$faces.play()
		if $/root/Main/Player.rage_level < 1:
			$faces.animation = "normal"
		elif $/root/Main/Player.rage_level < 2:
			$faces.animation = "slight"
		else:
			$faces.animation = "crazy"
		
		$TextureProgressBar.value = $/root/Main/Player.rage_level
