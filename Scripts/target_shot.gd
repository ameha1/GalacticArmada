extends Node2D

@onready var targetShot = $AnimationPlayer

func _ready():
	pass

func targetAcquired():
	targetShot.play("target_acquired")
