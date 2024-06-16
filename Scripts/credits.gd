extends Control

@onready var player = $player
@onready var screenTransition = $SceneTransition
func _ready():
	player.play("mover")

func _on_button_pressed():
	screenTransition.play("fade")
	await get_tree().create_timer(1).timeout
	get_tree().change_scene_to_file("res://Scenes/OpeningScene/openingScene.tscn")

