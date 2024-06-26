extends Area2D

@onready var meteorEffect = preload("res://Scenes/MereorScene/meteor_effect.tscn")
@onready var scorePoint = preload("res://Scenes/ScorePointScene/score_point.tscn")

@export var min_speed = 50
@export var max_speed = 100

var meteor_damagePoint = 10

@export var min_rotation = -25
@export var max_rotation = 25

@onready var meteorAudio = $MeteorAudio

var speed = randf_range(min_speed, max_speed)
var m_rotation = randf_range(min_rotation, max_rotation)

var playerInArea: Player = null

func _process(delta):
	
	if playerInArea != null:
		playerInArea.damage(1)
	
func _physics_process(delta):

	rotation_degrees += m_rotation * delta
	position.y += speed * delta
	
func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()

func damage(amount):
	meteorAudio.meteorHitAudioPlay()
	meteor_damagePoint -= amount
	
	if  meteor_damagePoint <= 0:
		meteorAudio.meteorDestructiomAudioPlay()
		
		for child in get_children():
			if child != meteorAudio:
				remove_child(child)
				child.queue_free()
		
		var effect = meteorEffect.instantiate()
		effect.position = position
		get_tree().current_scene.add_child(effect)
		
		hide()
		
		Signals.emit_signal("on_score_increment",1)

func _on_area_entered(area):
	var point = scorePoint.instantiate()
	point.global_position = global_position
	get_tree().current_scene.add_child(point)
	
	Signals.emit_signal("on_score_increment",1)
	if area is Player:
		playerInArea = area

func _on_area_exited(area):
	if area is Player:
		playerInArea = null
