extends Area2D

@onready var p_bulletEffect = preload("res://Scenes/BulletScene/bullet_effect.tscn")

@export var speed:float = 8

func _ready():
	pass

func _process(delta):
	position.y -= speed

func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()

func _on_area_entered(area):
	
	var bulletEffect = p_bulletEffect.instantiate()
	bulletEffect.position = position
	get_tree().current_scene.add_child(bulletEffect)
	
	#var view = get_tree().current_scene.find_child("View",true,false)
	#view.shake(3)
	
	if area.is_in_group('damagable'):
		area.damage(1)
	
	queue_free()
