extends Label

@onready var scorePoint = $AnimationPlayer
@onready var score = $"."

func _ready():
	scorePoint.play("score_point")
	
func _process(delta):
	score.text = "+" + str(Signals.scorePoint)
