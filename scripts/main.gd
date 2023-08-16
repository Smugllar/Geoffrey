extends Node

@export_category("Levels")
@export var Level1: PackedScene
@export var Level2: PackedScene
@export var Level3: PackedScene
@export var Level4: PackedScene
@export var Level5: PackedScene

# Called when the node enters the scene tree for the first time.
func _ready():
	$MenuMusic.play()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func level_1():
	add_child(Level1.instantiate())
	$CanvasLayer.in_game = true
	$MenuMusic.stop()

func died():
	$Death.play()
	await get_tree().create_timer(2.0).timeout
	$Fail.play()
	get_tree().call_group("main", "reset")

func reset():
	await get_tree().create_timer(3.0).timeout
	$MenuMusic.play()
