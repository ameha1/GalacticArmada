extends Area2D

@onready var meteorEffect = preload("res://Scenes/MereorScene/meteor_effect.tscn")


@export var min_speed = 50
@export var max_speed = 100

var meteor_damagePoint = 10

@export var min_rotation = -25
@export var max_rotation = 25

var speed = randf_range(min_speed, max_speed)
var m_rotation = randf_range(min_rotation, max_rotation)

var playerInArea: Player = null

func _process(delta):
	
	if playerInArea != null:
		playerInArea.damage(1)
		
	if meteor_damagePoint <= 0:
		queue_free()
	

func _physics_process(delta):

	rotation_degrees += m_rotation * delta
	position.y += speed * delta
	


func _on_visible_on_screen_notifier_2d_screen_exited():

	queue_free()

func damage(amount):

	meteor_damagePoint -= amount
	
	if  meteor_damagePoint <= 0:
		var effect = meteorEffect.instantiate()
		effect.position = position
		get_tree().current_scene.add_child(effect)
		Signals.emit_signal("on_score_increment",1)
		
		queue_free()

func _on_area_entered(area):
	if area is Player:
		playerInArea = area

func _on_area_exited(area):
	if area is Player:
		playerInArea = null
		


