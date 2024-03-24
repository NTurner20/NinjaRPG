extends CanvasLayer

@onready var inventory = $Inventory_gui
@onready var pauseScreen = $PauseScreen
func _ready():
	inventory.close()
	pauseScreen.resume()

func _input(event):
	if event.is_action_pressed("toggle_inventory"):
		if inventory.isOpen:
			inventory.close()
		else:
			inventory.open()
	if event.is_action_pressed("pause"):
		if pauseScreen.isPaused:
			pauseScreen.resume()
		else:
			pauseScreen.pause()
