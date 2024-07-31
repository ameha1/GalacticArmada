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

@export var phaseNTime = 0

var target_position = Vector2()

func _ready():
	randomize()
	spawnTimer.start(nextSpawnTime)

func _process(delta):
	score = HUDscore.setScore()
	
	Targets.steadyEnemyTargetPosition.x  = target_position.x
	#Targets.bouncerEnemyTargetPosition.x = target_position.x
	Targets.fastEnemyTargetPosition.x    = target_position.x
	
	#print('nextSpawnTime - ',nextSpawnTime,'  phaseNtime - ',phaseNTime)

func _on_spawn_timer_timeout():
	var viewRect = get_viewport_rect()
	var xPos = randi_range(viewRect.position.x,viewRect.end.x)
	
	if score <= 100:
		var steadyEnemy = preloadedSteadyEnemy.instantiate()
		steadyEnemy.position = Vector2(xPos,position.y)
		get_tree().current_scene.add_child(steadyEnemy)
		target_position = steadyEnemy.global_position
		
	if score <= 200 and score > 100:
		var bouncerEnemy = preloadedBouncerEnemy.instantiate()
		bouncerEnemy.position = Vector2(xPos,position.y)
		get_tree().current_scene.add_child(bouncerEnemy)
		target_position = bouncerEnemy.global_position
		
	if score <= 600 and score > 200:
		var fastEnemy = preloadedFastShooterEnemy.instantiate()
		fastEnemy.position = Vector2(xPos,position.y)
		get_tree().current_scene.add_child(fastEnemy)
		target_position = fastEnemy.global_position
		
	spawnTimer.start(nextSpawnTime)
	
	if nextSpawnTime == MIN_SPAWN_TIME:
		#print('waiting for 10 seconds')
		await get_tree().create_timer(phaseNTime).timeout
		nextSpawnTime = MAX_SPAWNTIME
		nextSpawnTime += 2

	if nextSpawnTime == MAX_SPAWNTIME:
		phaseNTime += 10
		
	nextSpawnTime -= 2
	
