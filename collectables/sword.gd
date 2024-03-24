extends "res://collectables/collectable.gd"

@onready var animator = $AnimationPlayer

func collect(inventory : Inventory):
	animator.play("spin")
	await animator.animation_finished
	super(inventory)
