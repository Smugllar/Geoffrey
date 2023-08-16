extends Node2D

var pan = false
var egg = false

func _ready():
	$Kitchen/PanPosition/pan.hide()
	$Kitchen/PanPosition/egg.hide()
	$Kitchen/EggPosition/egg.hide()
	$Kitchen/EggPosition/meal.hide()


func reset():
	await get_tree().create_timer(3.0).timeout
	queue_free()


func _on_kitchen_body_entered(body):
	#if pan enters kitchen
	if len(get_tree().get_nodes_in_group("pan")) > 0:
		if body == get_tree().get_nodes_in_group("pan")[0]:
			get_tree().call_group("pan", "bruh")
			$Kitchen/PanPosition/pan.show()
			pan = true
	
	if len(get_tree().get_nodes_in_group("EGG")) > 0:
		if body == get_tree().get_nodes_in_group("EGG")[0]:
			get_tree().call_group("EGG", "egg")
			if pan:
				$Kitchen/PanPosition/egg.show()
			else:
				$Kitchen/EggPosition/egg.show()
			egg = true
	
	if egg and pan:
		cook()


func cook():
	if $Kitchen/EggPosition/egg.visible == true:
		$Kitchen/EggPosition/egg.hide()
	
	$Kitchen/PanPosition/egg.show()
	$Kitchen/PanPosition/Sizzle.play()
	await get_tree().create_timer(34.0).timeout
	$Kitchen/PanPosition/egg.hide()
	$Kitchen/PanPosition/pan.hide()
	$Kitchen/EggPosition/meal.show()
