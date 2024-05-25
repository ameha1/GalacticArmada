extends Control

var playerLife = 8

func _ready():
	Signals.on_playerLife_changed.connect(on_playerLife)
	hide()

func _process(delta):
	
	if playerLife <= 0:
		show()
	
func _on_play_again_pressed():
	
	get_tree().change_scene_to_file("res://Scenes/MainScene/GamePlay.tscn")


func _on_exit_pressed():
	get_tree().quit()

func on_playerLife(life):
	playerLife = life
