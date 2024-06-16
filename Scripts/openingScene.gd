extends Node

@onready var station = $station
@onready var screenTransition = $SceneTransition
@onready var screenTime = $Timer

var screenTimeOut = false

func _ready():
	pass
	
func _process(delta):
	station.rotation += 0.001


func _on_play_pressed():
	screenTransition.play("fade")
	await get_tree().create_timer(1).timeout
	get_tree().change_scene_to_file("res://Scenes/MainScene/GamePlay.tscn")

func _on_about_pressed():
	screenTransition.play("fade")
	await get_tree().create_timer(1).timeout
	get_tree().change_scene_to_file("res://Scenes/CreditsScene/credits.tscn")

func _on_exit_pressed():
	screenTransition.play("fade")
	await get_tree().create_timer(1).timeout
	get_tree().quit()

