extends Control


signal paused
signal playing

var isPaused : bool = false
func pause():
	visible = true
	isPaused = true
	paused.emit()

func resume():
	visible = false
	isPaused = false
	playing.emit()
