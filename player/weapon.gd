extends Node2D

var weapon : Area2D 

func _ready():
	if get_children().is_empty(): return
	weapon = get_children()[0]

	
func enable():
	if weapon == null: return
	visible = true
	weapon.enable()
	
func disable():
	if weapon == null: return
	visible = false
	weapon.disable()
