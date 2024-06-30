extends Node2D

const MIN_SPAWN_TIME = 1.5

@onready var spawnTimer = $spawnTimer

var preloadedEnemies = [
	preload("res://Scenes/EnemyScene/enemy.tscn"),
	preload("res://Scenes/EnemyScene/bouncer_enemy.tscn")
]

var preloadedElements = [
	preload("res://Scenes/ShieldPower/shieldPower.tscn"),
	preload("res://Scenes/RapidFireUp/rapid_fire_up.tscn")

]

var pMeteor = preload("res://Scenes/MereorScene/meteor.tscn")

var nextSpawnTime = 10

func _ready():
	randomize()
	spawnTimer.start(nextSpawnTime)

func _on_spawn_timer_timeout():
	var viewRect = get_viewport_rect()
	var xPos = randi_range(viewRect.position.x,viewRect.end.x)
	
	if randf() < 0.1:
		var meteor = pMeteor.instantiate()
		meteor.position = Vector2(xPos,position.y)
		get_tree().current_scene.add_child(meteor)
		
		var elementsPreload = preloadedElements[randi() % preloadedElements.size()]
		var element = elementsPreload.instantiate()
		element.position = Vector2(xPos,position.y)
		get_tree().current_scene.add_child(element)
		
	else:
		var enemyPreload = preloadedEnemies[randi() % preloadedEnemies.size()]
		var enemy = enemyPreload.instantiate()
		enemy.position = Vector2(xPos,position.y)
		
		get_tree().current_scene.add_child(enemy)
		
		
	
	nextSpawnTime -= 0.1
	
	if nextSpawnTime < MIN_SPAWN_TIME:
		nextSpawnTime = MIN_SPAWN_TIME
	
	spawnTimer.start(nextSpawnTime)
	
	
