extends Node
var speed = 80

@onready var stars = $DarkBackGround/stars
@onready var opener = $openingScene
@onready var gameScore = $CanvasLayer/HUD

@export var max_starSpeed = 10

var state = false
var count = 0

func _ready():
	
	#ship flying enterance to the scene is initialized
	opener.play("opening_scene")

func _process(delta):
	#illucinates the perception of speedingup in space
	
	if Input.is_action_pressed("accelerate"):
		if stars.speed_scale <= max_starSpeed:
			stars.speed_scale += 0.002
	
	else:
		if stars.speed_scale >= 0.5:
			stars.speed_scale -= 0.003

func _on_opening_scene_animation_finished(opening_scene):
		state = true
		Signals.emit_signal("openingScene_notifier",state)


