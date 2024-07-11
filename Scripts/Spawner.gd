extends Node2D

const MIN_SPAWN_TIME = 1.5

@onready var spawnTimer = $spawnTimer

var preloadedSteadyEnemy = preload("res://Scenes/EnemyScene/enemy.tscn")
var preloadedBouncerEnemy =  preload("res://Scenes/EnemyScene/bouncer_enemy.tscn")
var pMeteor = preload("res://Scenes/MereorScene/meteor.tscn")


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
	
	#if randf() < 0.1:
		#var meteor = pMeteor.instantiate()
		#meteor.position = Vector2(xPos,position.y)
		#get_tree().current_scene.add_child(meteor)
		#
		#var elementsPreload = preloadedElements[randi() % preloadedElements.size()]
		#var element = elementsPreload.instantiate()
		#element.position = Vector2(xPos,position.y)
		#get_tree().current_scene.add_child(element)
		#
	#else:
		#var enemyPreload = preloadedEnemies[randi() % preloadedEnemies.size()]
		#var enemy = enemyPreload.instantiate()
		#enemy.position = Vector2(xPos,position.y)
		#
		#get_tree().current_scene.add_child(enemy)
	
	if score % 11 == 0:
		var meteor = pMeteor.instantiate()
		meteor.position = Vector2(xPos,position.y)
		get_tree().current_scene.add_child(meteor)
		
	if score % 13 == 0:
		var shield = preloadedShieldPower.instantiate()
		shield.position = Vector2(xPos,position.y)
		get_tree().current_scene.add_child(shield)
		
		var rapidFire = preloadedRapidFireUp.instantiate()
		rapidFire.position = Vector2(xPos,position.y)
		get_tree().current_scene.add_child(rapidFire)
	
	if score <= 50:
		var steadyEnemy = preloadedSteadyEnemy.instantiate()
		steadyEnemy.position = Vector2(xPos,position.y)
		get_tree().current_scene.add_child(steadyEnemy)
	elif score <= 150:
		var bouncerEnemy = preloadedBouncerEnemy.instantiate()
		bouncerEnemy.position = Vector2(xPos,position.y)
		get_tree().current_scene.add_child(bouncerEnemy)
	
	nextSpawnTime -= 0.1
	
	if nextSpawnTime < MIN_SPAWN_TIME:
		nextSpawnTime = MIN_SPAWN_TIME
	
	spawnTimer.start(nextSpawnTime)
	
	
