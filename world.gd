extends Node2D

@onready var heartsContainer = $CanvasLayer/heartsContainer
@onready var player = $Player
@onready var bgMusic : AudioStreamPlayer2D = $BG_Music

var musicPos = 0.0
# Called when the node enters the scene tree for the first time.
func _ready():
	heartsContainer.setMaxHearts(player.maxHealth)
	heartsContainer.updateHearts(player.currentHealth)
	player.healthChanged.connect(heartsContainer.updateHearts)
	bgMusic.play()



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_inventory_gui_closed():
	get_tree().paused = false
	$BG_Music.play(musicPos)

func _on_inventory_gui_opened():
	get_tree().paused = true
	musicPos = $BG_Music.get_playback_position()
	$BG_Music.stop()

func _on_pause_screen_paused():
	get_tree().paused = true
	musicPos = $BG_Music.get_playback_position()
	$BG_Music.stop()



func _on_pause_screen_playing():
	get_tree().paused = false
	$BG_Music.play(musicPos)

