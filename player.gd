extends CharacterBody2D
@export var player_speed = 100
@onready var animated_sprite = $AnimatedSprite2D


@export var maxHealth = 3
@onready var currentHealth : int = maxHealth
func _process(delta):
	var direction = Vector2(
  	 Input.get_action_strength("right") - Input.get_action_strength("left"),
  	 Input.get_action_strength("down") - Input.get_action_strength("up")
	)
	direction = direction.normalized()

	velocity = direction * player_speed

	move_and_slide()

	# Update animation or other character states here
	if velocity == Vector2.ZERO:
		animated_sprite.stop()
	else:
		if velocity.y > 0:
			animated_sprite.play("walk_down")
		elif velocity.x > 0:
			animated_sprite.play("walk_right")
		elif velocity.y < 0:
			animated_sprite.play("walk_up")
		else:
			animated_sprite.play("walk_left")



func _on_hurt_box_area_entered(area):
	if area.name == "hitBox":
		currentHealth -= 1
		if currentHealth < 0:
			currentHealth = maxHealth
		
