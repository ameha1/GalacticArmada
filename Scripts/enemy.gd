extends Area2D

class_name Enemy

@export var enemy_lives = 6

@onready var WeaponPosition = $WeaponPosition
@onready var enemyAudio = $EnemyAudio
@onready var detectionZone = $DetectionZone
@onready var collisionZone = $CollisionPolygon2D
@onready var targetShot = $TargetShot

var pl_bullet = preload("res://Scenes/BulletScene/enemy_bullet.tscn")
var enemyExplosion = preload("res://Scenes/EnemyScene/enemy_explosion.tscn")
var scorePoint = preload("res://Scenes/ScorePointScene/score_point.tscn")

@onready var timeOut = false
@onready var Detection_Activation = false


func _ready():
	pass

func _process(delta):
	if Detection_Activation and timeOut:
		fire()
	
func _physics_process(delta):
	var speed = Signals.enemySpeed
	position.y += speed*delta
	
	Targets.steadyEnemyTargetPosition.y = position.y

func damage(amount):
	enemyAudio.enemyHitAudioPlay()
	enemy_lives -= amount
	
	var view = get_tree().current_scene.find_child("View",true,false)
	view.shake(3)
	
	if enemy_lives <= 0:
		enemyAudio.enemyDestructionAudioPlay()
		
		for child in get_children():
			if child != enemyAudio:
				remove_child(child)
				child.queue_free()
		
		var effect = enemyExplosion.instantiate()
		effect.position = position
		get_tree().current_scene.add_child(effect)
		
		hide()
		
		Signals.emit_signal("on_score_increment",1)
		
func fire():
	enemyAudio.enemyDFireAudioPlay()
	for child in WeaponPosition.get_children():
		var bullet = pl_bullet.instantiate()
		bullet.global_position = child.global_position
		get_tree().current_scene.add_child(bullet)
		timeOut=false

func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()

func _on_cool_down_timeout():
	timeOut = true

func _on_detection_zone_area_entered(area):
	if area is Player:
		Detection_Activation = true
		if Signals.missileLeft > 0 and global_position.x == Targets.steadyEnemyTargetPosition.x:
			targetEnemy()

func _on_detection_zone_area_exited(area):
	if area is Player:
		Detection_Activation = false

func _on_area_entered(area):
	var point = scorePoint.instantiate()
	point.global_position = global_position
	get_tree().current_scene.add_child(point)
	
	Signals.emit_signal("on_score_increment",1)
	
	if area.is_in_group('damagable'):
		area.damage(1)

func targetEnemy():
	targetShot.targetAcquired()
	
