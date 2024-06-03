extends Control

@onready var gameOver = $gameOverPlayer

var playerLife = 8
var gameOverPullUp = false

func _ready():
	Signals.on_playerLife_changed.connect(on_playerLife)

func _process(delta):
	if playerLife <= 0:
		gameOver.play("gameover")
		return
	
func _on_retry_pressed():
	get_tree().change_scene_to_file("res://Scenes/MainScene/GamePlay.tscn")	
#func _on_play_again_pressed():
	#get_tree().change_scene_to_file("res://Scenes/MainScene/GamePlay.tscn")

func _on_exit_pressed():
	get_tree().quit()

func on_playerLife(life):
	playerLife = life

func _on_about_pressed():
	get_tree().change_scene_to_file("res://Scenes/CreditsScene/credits.tscn")


