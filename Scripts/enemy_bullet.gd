extends Area2D

class_name EnemyBullet

@onready var p_bulletEffect = preload("res://Scenes/BulletScene/enemy_bullet_effect.tscn")

@export var speed:float = 8

var activated = false

func _ready():
	Signals.shieldActivation.connect(shield_activation)

func _process(delta):
	position.y += speed

func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()

func _on_area_entered(area):
	
	var bulletEffect = p_bulletEffect.instantiate()
	bulletEffect.position = position
	get_tree().current_scene.add_child(bulletEffect)
	
	var activated = shield_activation(area)

	if area.is_in_group('damagable') and !activated:
		area.damage(1)
	
	queue_free()

func shield_activation(activation):
	activated = activation

