extends Node2D

const MIN_SPAWN_TIME = 200

@onready var spawnTimer = $spawnTimer

var preloadedShieldPower = preload("res://Scenes/ShieldPower/shieldPower.tscn")
var preloadedRapidFireUp = preload("res://Scenes/RapidFireUp/rapid_fire_up.tscn")

@onready var HUDscore = $"../CanvasLayer/HUD"
var score = 0 

@export var nextSpawnTime = 20

func _ready():
	randomize()
	spawnTimer.start(nextSpawnTime)

func _process(delta):
	score = HUDscore.setScore()

func _on_spawn_timer_timeout():
	var viewRect = get_viewport_rect()
	var xPos1 = randi_range(viewRect.position.x,viewRect.end.x)
	var xPos2 = randi_range(viewRect.position.x,viewRect.end.x)

	
	var shield = preloadedShieldPower.instantiate()
	shield.position = Vector2(xPos1,position.y)
	get_tree().current_scene.add_child(shield)
	
	var rapidFire = preloadedRapidFireUp.instantiate()
	rapidFire.position = Vector2(xPos2,position.y)
	get_tree().current_scene.add_child(rapidFire)
	
	nextSpawnTime += 5
	
	if nextSpawnTime > MIN_SPAWN_TIME:
		nextSpawnTime = MIN_SPAWN_TIME
	
	spawnTimer.start(nextSpawnTime)
