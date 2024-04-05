extends CanvasLayer

@onready var inventory = $Inventory_gui
@onready var pauseScreen = $PauseScreen
@onready var coinsLabel = $Coins
@onready var bgMusic : AudioStreamPlayer = $"../BG_Music"



func _ready():
	inventory.close()
	pauseScreen.resume()
	bgMusic.play()
	coinsLabel.visible = false

func _input(event):
	if event.is_action_pressed("toggle_inventory") and !pauseScreen.isPaused:
		if inventory.isOpen:
			inventory.close()
			coinsLabel.visible = false
			bgMusic.volume_db = 0
		else:
			inventory.open()
			coinsLabel.visible = true
			bgMusic.volume_db = -15
	if event.is_action_pressed("pause") and !inventory.isOpen:
		if pauseScreen.isPaused:
			pauseScreen.resume()
			coinsLabel.visible = false
			bgMusic.volume_db = 0
		else:
			pauseScreen.pause()
			coinsLabel.visible = true
			bgMusic.volume_db = -15
