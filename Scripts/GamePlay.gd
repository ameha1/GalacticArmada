extends Node
var speed = 80

@onready var stars = $DarkBackGround/stars
@onready var spawner = $Spawner
@onready var opener = $openingScene

@export var max_starSpeed = 10

var state = false
var count = 0

func _ready():
	
	opener.play("opening_scene")
	

func _process(delta):
	
	
	if Input.is_action_pressed("accelerate"):

		if stars.speed_scale <= max_starSpeed:
			stars.speed_scale += 0.001
			
			
	else:
		if stars.speed_scale >= 0.5:
			stars.speed_scale -= 0.002


func _on_opening_scene_animation_finished(opening_scene):
		
		state = true
		Signals.emit_signal("openingScene_notifier",state)
