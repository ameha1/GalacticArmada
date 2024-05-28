extends Node

@onready var station = $station

func _ready():
	pass
	
func _process(delta):
	station.rotation += 0.001

func _on_play_pressed():
	
	get_tree().change_scene_to_file("res://Scenes/MainScene/GamePlay.tscn")

func _on_about_pressed():
	get_tree().change_scene_to_file("res://Scenes/CreditsScene/credits.tscn")

func _on_exit_pressed():
	get_tree().quit()
