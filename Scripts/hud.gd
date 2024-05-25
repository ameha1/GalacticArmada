extends Node

var plifeIcon = preload("res://Scenes/HUD/life_icon.tscn")

@onready var lifeContainer = $LifeContainer
@onready var Score = $Label

var score = 0

func _ready():

	clear_lives()
	Signals.on_playerLife_changed.connect(playerLife_changed)
	Signals.on_score_increment.connect(_on_score_increment)


func clear_lives():
	for child in lifeContainer.get_children():
		lifeContainer.remove_child(child)
		child.queue_free()

func set_lives(lives):
	clear_lives()
	for i in range(lives):
		lifeContainer.add_child(plifeIcon.instantiate())

func _on_score_increment(amount):
	score += amount
	Score.text = str(score)

func playerLife_changed(life):
	set_lives(life)




