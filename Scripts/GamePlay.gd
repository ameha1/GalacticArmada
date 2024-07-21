extends Node
var speed = 80

@onready var stars = $DarkBackGround/stars
@onready var opener = $openingScene
@onready var gameScore = $CanvasLayer/HUD
@onready var powerUpSpeed = $ShieldPower

@export var max_starSpeed = 10
var max_powerupSpeed = 2
var min_powerupSpeed = 0.7

var state = false
var count = 0

func _ready():
	
	#ship flying enterance to the scene is initialized
	Signals.powerupSpeed = 0.7
	opener.play("opening_scene")

func _process(delta):
	#illucinates the perception of speedingup in space
	if Input.is_action_pressed("accelerate"):
		if Signals.powerupSpeed <= max_powerupSpeed:
			Signals.powerupSpeed += 0.1
		if stars.speed_scale <= max_starSpeed:
			stars.speed_scale += 0.002
	
	else:
		if Signals.powerupSpeed > min_powerupSpeed:
			Signals.powerupSpeed -= 0.1
		if stars.speed_scale >= 0.5:
			stars.speed_scale -= 0.003

func _on_opening_scene_animation_finished(opening_scene):
		state = true
		Signals.emit_signal("openingScene_notifier",state)


