extends Area2D

class_name Enemy

@export var speed = 80
@export var enemy_lives = 8

@onready var WeaponPosition = $WeaponPosition

var pl_bullet = preload("res://Scenes/BulletScene/enemy_bullet.tscn")

@onready var timeOut = false
@onready var Detection_Activation = false

#var playerInArea: Player = null

func _process(delta):
	
	if Detection_Activation and timeOut:
		fire()

func _physics_process(delta):
	
	position.y += speed*delta

func damage(amount):
	
	enemy_lives -= amount
	
	if enemy_lives <= 0:
		Signals.emit_signal("on_score_increment",1)
		queue_free()

func fire():
	
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
	if area.is_in_group('damagable'):
		area.damage(1)
