extends Node2D

const MIN_SPAWN_TIME = 1.5

@onready var spawnTimer = $spawnTimer

var preloadedShieldPower = preload("res://Scenes/ShieldPower/shieldPower.tscn")
var preloadedRapidFireUp = preload("res://Scenes/RapidFireUp/rapid_fire_up.tscn")

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
	var xPos = randi_range(viewRect.position.x,viewRect.end.x)

	if score % 50 == 0:
		var shield = preloadedShieldPower.instantiate()
		shield.position = Vector2(xPos,position.y)
		get_tree().current_scene.add_child(shield)
	
		var rapidFire = preloadedRapidFireUp.instantiate()
		rapidFire.position = Vector2(xPos,position.y)
		get_tree().current_scene.add_child(rapidFire)
	
	nextSpawnTime -= 0.1
	
	if nextSpawnTime < MIN_SPAWN_TIME:
		nextSpawnTime = MIN_SPAWN_TIME
	
	spawnTimer.start(nextSpawnTime)
