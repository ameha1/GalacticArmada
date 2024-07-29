extends Node2D

const MIN_SPAWN_TIME = 200

@onready var spawnTimer = $spawnTimer

var preloadedShieldPower = preload("res://Scenes/ShieldPower/shieldPower.tscn")
var preloadedRapidFireUp = preload("res://Scenes/RapidFireUp/rapid_fire_up.tscn")
var preloadedMissile = preload("res://Scenes/MissileScene/missile_power.tscn")


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
	var xPos3 = randi_range(viewRect.position.x,viewRect.end.x)
	var yPos1 = randi_range(-200,-300)
	var yPos2 = randi_range(-250,-300)
	var yPos3 = randi_range(-250,-300)

	
	var shield = preloadedShieldPower.instantiate()
	shield.position = Vector2(xPos1,yPos1)
	get_tree().current_scene.add_child(shield)
	
	await get_tree().create_timer(5).timeout
	
	var rapidFire = preloadedRapidFireUp.instantiate()
	rapidFire.position = Vector2(xPos2,yPos2)
	get_tree().current_scene.add_child(rapidFire)
	
	await get_tree().create_timer(5).timeout
	
	var missile = preloadedMissile.instantiate()
	missile.position = Vector2(xPos3,yPos3)
	get_tree().current_scene.add_child(missile)
	
	nextSpawnTime += 5
	
	if nextSpawnTime > MIN_SPAWN_TIME:
		nextSpawnTime = MIN_SPAWN_TIME
	
	spawnTimer.start(nextSpawnTime)
