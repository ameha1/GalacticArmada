extends Node2D


@onready var spawnTimer = $spawnTimer

var preloadedMeteor = preload("res://Scenes/MereorScene/meteor.tscn")

@onready var HUDscore = $"../CanvasLayer/HUD"
var score = 0 

@export var nextSpawnTime = 10

func _ready():
	randomize()
	spawnTimer.start(nextSpawnTime)

func _process(delta):
	score = HUDscore.setScore()

func _on_spawn_timer_timeout():
	var viewRect = get_viewport_rect()
	var xPos1 = randi_range(viewRect.position.x,viewRect.end.x)
	var yPos1 = randi_range(-200,-300)
	
	var meteor = preloadedMeteor.instantiate()
	meteor.position = Vector2(xPos1,yPos1)
	get_tree().current_scene.add_child(meteor)
	
	nextSpawnTime += 10
	
	spawnTimer.start(nextSpawnTime)
