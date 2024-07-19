extends Node

var plifeIcon = preload("res://Scenes/HUD/life_icon.tscn")

@onready var score = 0
@onready var lifeContainer = $LifeContainer
@onready var Score = $Label
@onready var spawnerTimeSetter = $"../.."
@onready var player = $"../../Player"
@onready var game_over = $gameover

func _ready():
	clear_lives()
	Signals.on_playerLife_changed.connect(playerLife_changed)
	Signals.on_score_increment.connect(_on_score_increment)
	
func _process(delta):
	pass
func clear_lives():
	for child in lifeContainer.get_children():
		lifeContainer.remove_child(child)
		child.queue_free()

func set_lives(lives):
	clear_lives()
	for i in range(lives):
		lifeContainer.add_child(plifeIcon.instantiate())
	if lives <= 0:
		player.RecordPlayerScores(score)
	
func _on_score_increment(amount):
if not gameover.animeplayer.is_playing():
	score += amount
	Score.text = str(score)

func playerLife_changed(life):
	set_lives(life)

func setScore():
	return score

