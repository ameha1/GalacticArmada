extends Control

@onready var pauseBG = $PauseBG
@onready var pauseButton = $PauseButton
@onready var playButton = $PlayButton 

func _ready():
	pauseBG.hide()
	playButton.hide()


func _on_pause_button_pressed():
	pauseButton.hide()
	
	playButton.show()
	pauseBG.show()
	
	get_tree().paused = true
	process_mode = Node.PROCESS_MODE_WHEN_PAUSED
	

func _on_play_button_pressed():
	playButton.hide()
	pauseBG.hide()
	
	pauseButton.show()
	
	get_tree().paused = false
	process_mode = Node.PROCESS_MODE_PAUSABLE
