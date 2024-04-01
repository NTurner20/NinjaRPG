extends Area2D

@onready var shape = $CollisionShape2D
func _ready():
	shape.disabled = true

func enable():
	shape.disabled = false
func disable():
	shape.disabled = true
