extends CharacterBody2D

@export var player_speed = 100
@export var maxHealth = 3
@export var knockbackPower : int = 500
@export var inventory : Inventory

@onready var animator = $AnimationPlayer
@onready var currentHealth : int = maxHealth
@onready var effects = $Effects
@onready var hurtBox = $hurtBox
@onready var hurtTimer = $hurtTimer
@onready var weapon = $weapon
@onready var soundFX : AudioStreamPlayer = $"../soundFX"
@onready var hurtSound = preload("res://Assets/Sounds/Hit.wav")
@onready var pickupSoundHealthPot = preload("res://NinjaAdventure/Sounds/Game/Gold1.wav")

var isHurt : bool = false
var lastAnimDirection : String = "down"
var isAttacking : bool = false

signal healthChanged

func _ready():
	effects.play("RESET")
	weapon.disable()
	
func handleInput():
	var direction = Vector2(
  	 Input.get_action_strength("right") - Input.get_action_strength("left"),
  	 Input.get_action_strength("down") - Input.get_action_strength("up")
	)
	velocity = direction * player_speed
	direction = direction.normalized()
	if Input.is_action_just_pressed("attack"):
		attack()
	
func attack():
	weapon.enable()
	animator.play("attack_"+lastAnimDirection)
	isAttacking = true
	await animator.animation_finished
	weapon.disable()
	isAttacking = false
	

	
func updateAnimation():
	# Update animation or other character states here
	if isAttacking: return
	if velocity == Vector2.ZERO:
		animator.stop()
	else:
		var direction = "down"
		if velocity.y > 0: direction = "down"
		elif velocity.x > 0: direction = "right"
		elif velocity.y < 0: direction = "up"
		else: direction = "left"
		animator.play("walk_"+direction)
		lastAnimDirection = direction
			

func _physics_process(_delta):
	handleInput()
	move_and_slide()
	updateAnimation()
	if !isHurt:
		for area in hurtBox.get_overlapping_areas():
			if area.name == 'hitBox':
				hurtByEnemy(area)


func hurtByEnemy(area):
	currentHealth -= 1
	if currentHealth < 0:
		currentHealth = maxHealth
	soundFX.stream = hurtSound
	soundFX.play()
	healthChanged.emit(currentHealth)
	isHurt = true
	knockback(area.get_parent().velocity)
	effects.play("hurtBlink")
	hurtTimer.start()
	await hurtTimer.timeout
	effects.play("RESET")
	isHurt = false


func knockback(enemyVelocity : Vector2):
	var knockbackDirection = (enemyVelocity-velocity).normalized() * knockbackPower
	velocity = knockbackDirection
	move_and_slide()

func _on_hurt_box_area_entered(area):
	if area.has_method("collect"):
		area.collect(inventory)

		
func _on_hurt_box_area_exited(area):
	pass

