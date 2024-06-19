extends Area2D

class_name Enemy

@export var speed = 80
@export var enemy_lives = 8

@onready var WeaponPosition = $WeaponPosition

var pl_bullet = preload("res://Scenes/BulletScene/enemy_bullet.tscn")
var enemyExplosion = preload("res://Scenes/EnemyScene/enemy_explosion.tscn")
var scorePoint = preload("res://Scenes/ScorePointScene/score_point.tscn")

@onready var timeOut = false
@onready var Detection_Activation = false

@onready var enemyHitAudio = $EnemyHitAudio
@onready var enemyExplosionAudio = $EnemyExplosionAudio
@onready var enemyFireAudio = $EnemyFireAudio
#var playerInArea: Player = null

func _ready():
	pass

func _process(delta):
	
	if Detection_Activation and timeOut:
		fire()

func _physics_process(delta):
	
	position.y += speed*delta

func damage(amount):
	enemyHitAudio.play()
	enemy_lives -= amount
	
	if enemy_lives <= 0:
		Signals.emit_signal("on_score_increment",1)
		
		var effect = enemyExplosion.instantiate()
		effect.position = position
		get_tree().current_scene.add_child(effect)
		
		queue_free()
	
func fire():
	enemyFireAudio.play()
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

func _on_detection_zone_area_exited(area):
	if area is Player:
		Detection_Activation = false

func _on_area_entered(area):
	
	if enemy_lives <= 0:
		enemyExplosionAudio.play()
		
	var point = scorePoint.instantiate()
	point.global_position = global_position
	get_tree().current_scene.add_child(point)
	
	Signals.emit_signal("on_score_increment",1)
	
	if area.is_in_group('damagable'):
		area.damage(1)

