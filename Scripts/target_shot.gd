extends Node2D

@onready var targetShot = $AnimationPlayer
@onready var target = $TextureRect

func _ready():
	pass

func targetAcquired():
	targetShot.play("target_acquired")

func targetLost():
	target.hide()
	targetShot.stop()
