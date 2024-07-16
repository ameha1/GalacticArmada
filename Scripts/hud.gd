extends Node

var plifeIcon = preload("res://Scenes/HUD/life_icon.tscn")

@onready var lifeContainer = $LifeContainer
@onready var Score = $Label
@onready var spawnerTimeSetter = $"../.."

var score = 0
var scoreRecord_res = "res://scoreRecord.txt"
var scoreFile_W = FileAccess.open(scoreRecord_res,FileAccess.WRITE)
var scoreFile_R = FileAccess.open(scoreRecord_res,FileAccess.READ)
var scoreRecord = [0]

func _ready():
	clear_lives()
	Signals.on_playerLife_changed.connect(playerLife_changed)
	Signals.on_score_increment.connect(_on_score_increment)
	
func _process(delta):
	print(scoreRecord)

func clear_lives():
	for child in lifeContainer.get_children():
		lifeContainer.remove_child(child)
		child.queue_free()

func set_lives(lives):
	clear_lives()
	for i in range(lives):
		lifeContainer.add_child(plifeIcon.instantiate())
	if lives <= 0:
		scoreFile_W.store_string(str(score))
	
func _on_score_increment(amount):
	score += amount
	Score.text = str(score)

func playerLife_changed(life):
	set_lives(life)

func setScore():
	return score

func rtrnScoresRecord():
	if FileAccess.file_exists(scoreRecord_res):
		var bestscore = scoreFile_R.get_as_text()
		print(typeof(bestscore))
