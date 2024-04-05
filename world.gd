extends Node2D

@onready var heartsContainer = $CanvasLayer/heartsContainer
@onready var player = $Player

@onready var soundFX : AudioStreamPlayer = $soundFX


var musicPos = 0.0
# Called when the node enters the scene tree for the first time.
func _ready():
	heartsContainer.setMaxHearts(player.maxHealth)
	heartsContainer.updateHearts(player.currentHealth)




# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_inventory_gui_closed():
	get_tree().paused = false
	#$BG_Music.play(musicPos)



func _on_inventory_gui_opened():
	get_tree().paused = true


func _on_pause_screen_paused():
	get_tree().paused = true




func _on_pause_screen_playing():
	get_tree().paused = false


