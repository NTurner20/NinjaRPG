extends Area2D




func _on_area_entered(area):
	print_debug(area.name)
	if area.name == 'Player':
		queue_free()
