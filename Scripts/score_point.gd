extends Label

@onready var scorePoint = $AnimationPlayer

func _ready():
	scorePoint.play("score_point")
	
