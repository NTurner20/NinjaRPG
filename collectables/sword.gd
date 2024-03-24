extends "res://collectables/collectable.gd"

@onready var animator = $AnimationPlayer

func collect():
	animator.play("spin")
	await animator.animation_finished
	super.collect()
