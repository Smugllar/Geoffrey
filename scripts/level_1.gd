extends Node2D

func _ready():
	$Kitchen/PanPosition/Sprite2D.hide()


func reset():
	await get_tree().create_timer(3.0).timeout
	queue_free()


func _on_kitchen_body_entered(body):
	#if pan enters kitchen
	if body == get_tree().get_nodes_in_group("pan")[0]:
		get_tree().call_group("pan", "bruh")
		$Kitchen/PanPosition/Sprite2D.show()
