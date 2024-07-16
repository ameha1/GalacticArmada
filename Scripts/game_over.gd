extends Control

@onready var GamePlay = $"../.."
@onready var spawner = $"../../Spawner"

@onready var gameOver = $gameOverPlayer
@onready var screenTransition = $SceneTransition
@onready var gamePause = $"../GamePause"

@onready var scoreValue = $VBoxContainer/scoreBoard/scoreValue
@onready var bestscoreValue = $VBoxContainer/scoreBoard/bestScoreValue
@onready var hud = $"../HUD"

var playerLife = 8
var gameOverPullUp = false

func _ready():
	Signals.on_playerLife_changed.connect(on_playerLife)

func _process(delta):
	
	scoreValue.text = str(hud.setScore())
	bestscoreValue.text = str(hud.rtrnScoresRecord())

func _on_retry_pressed():
	screenTransition.play("fade")
	await get_tree().create_timer(1).timeout
	get_tree().change_scene_to_file("res://Scenes/MainScene/GamePlay.tscn")

func _on_exit_pressed():
	screenTransition.play("fade")
	await get_tree().create_timer(1).timeout
	get_tree().quit()

func on_playerLife(life):
	playerLife = life
	game_Over()

func _on_about_pressed():
	screenTransition.play("fade")
	await get_tree().create_timer(1).timeout
	get_tree().change_scene_to_file("res://Scenes/CreditsScene/credits.tscn")

func game_Over():
	if playerLife <= 0:
		gameOver.play("gameover")
		gamePause.hide()
		
		for child in GamePlay.get_children():
			if child == spawner:
				remove_child(child)
				child.queue_free()
