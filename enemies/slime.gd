extends CharacterBody2D

@export var speed = 100
@export var limit = 0.5
@export var endPoint : Marker2D
@onready var animator = $AnimationPlayer
@onready var deathSound = $deathSound


var startPosition
var endPosition
var isDead : bool = false
func _ready():
	startPosition  = position
	endPosition = endPoint.global_position
	
func changeDirection():
	var tempEnd = endPosition
	endPosition = startPosition
	startPosition = tempEnd
	
func updateAnimation():
	var animationString = 'walk_up'
	if abs(velocity.x) > abs(velocity.y):
		if velocity.x > 0:
			animationString = 'walk_right'
		else:
			animationString = 'walk_left'
	else:
		if velocity.y > 0 :
			animationString = 'walk_down'
		else:
			animationString = 'walk_up'
	
	animator.play(animationString)

	
func updateVelocity():
	var moveDirection = (endPosition - position)
	if moveDirection.length() < limit:
		position = endPosition
		changeDirection()
	velocity = moveDirection.normalized()*speed
	
func _physics_process(delta):
	if isDead : return
	updateVelocity()
	updateAnimation()
	move_and_slide()


func _on_hurt_box_area_entered(area):
	if area == $hitBox: return
	$hitBox.set_deferred("monitorable", false)
	isDead = true
	
	animator.play("death")
	await animator.animation_finished
	deathSound.play()
	queue_free()
