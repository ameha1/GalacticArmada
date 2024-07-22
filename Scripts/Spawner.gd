extends Node2D

const MIN_SPAWN_TIME = 2
const MAX_SPAWNTIME = 10

@onready var spawnTimer = $spawnTimer

var preloadedSteadyEnemy = preload("res://Scenes/EnemyScene/enemy.tscn")
var preloadedBouncerEnemy =  preload("res://Scenes/EnemyScene/bouncer_enemy.tscn")
var preloadedFastShooterEnemy = preload("res://Scenes/EnemyScene/fast_shooter_enemy.tscn")
var pMeteor = preload("res://Scenes/MereorScene/meteor.tscn")

@onready var HUDscore = $"../CanvasLayer/HUD"
var score = 0 

@export var nextSpawnTime = 10

@export var phaseNTime = 10

func _ready():
	randomize()
	spawnTimer.start(nextSpawnTime)

func _process(delta):
	score = HUDscore.setScore()
	#print('nextSpawnTime - ',nextSpawnTime,'  phaseNtime - ',phaseNTime)

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
	
	if score <= 100:
		var steadyEnemy = preloadedSteadyEnemy.instantiate()
		steadyEnemy.position = Vector2(xPos,position.y)
		get_tree().current_scene.add_child(steadyEnemy)
	if score <= 200 and score > 100:
		var bouncerEnemy = preloadedBouncerEnemy.instantiate()
		bouncerEnemy.position = Vector2(xPos,position.y)
		get_tree().current_scene.add_child(bouncerEnemy)
	if score <= 300 and score > 200:
		var fastEnemy = preloadedFastShooterEnemy.instantiate()
		fastEnemy.position = Vector2(xPos,position.y)
		get_tree().current_scene.add_child(fastEnemy)
	nextSpawnTime -= 0.5
	
	if nextSpawnTime < MIN_SPAWN_TIME:
		nextSpawnTime = MIN_SPAWN_TIME
	
	spawnTimer.start(nextSpawnTime)
	
	if nextSpawnTime == MIN_SPAWN_TIME:
		
		await get_tree().create_timer(phaseNTime).timeout
		nextSpawnTime = MAX_SPAWNTIME
