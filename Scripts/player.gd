extends Area2D

class_name Player

var pl_bullet = preload("res://Scenes/BulletScene/bullet.tscn")
var playerExplosion = preload("res://Scenes/PlayerScene/player_explosion.tscn")

@onready var speed = 200

var velocity = Vector2(0,0)

@onready var weaponPositions = $WeaponPositions
@onready var shield_activated = $shield
@onready var invinsibilityTimer = $InvisibilityTimer
@onready var shieldField = $shield/shieldField
@onready var coolDownTimer = $CoolDown
@onready var rapidFireTimer = $RapidFireTimer
@onready var fuel1 = $Fuel
@onready var fuel2 = $Fuel2

@onready var playerAudio = $PlayerAudio

@export var normalFireDelay = 0.2
@export var rapidFireDelay = 0.08
var fireDelay = normalFireDelay

var timeout = false
@export var shipLife = 3

func _ready():
	
	playerAudio.playerFuelAudioPlay()
	
	shield_activated.hide()
	Signals.openingScene_notifier.connect(player_state)
	Signals.emit_signal('on_playerLife_changed',shipLife)
	
	if fuel1.amount <= 6:
		fuel1.amount += 1 
	fuel1.lifetime = 0.25
	if fuel2.amount <= 6:
		fuel2.amount += 1 
	fuel2.lifetime = 0.25
	
func _process(delta):
	pass

func _physics_process(delta):
	var dir_vector = Vector2(0,0)

	if Input.is_action_just_pressed("accelerate"):
		if playerAudio.playerFuelAudio.pitch_scale <= 3:
			playerAudio.playerFuelAudio.pitch_scale += 0.1
			
		if get_children().size() > 1:
			if fuel1.amount <= 6:
				fuel1.amount += 1 
			fuel1.lifetime = 0.25
			if fuel2.amount <= 6:
				fuel2.amount += 1 
			fuel2.lifetime = 0.25
		
	if Input.is_action_just_released("accelerate"):
		if playerAudio.playerFuelAudio.pitch_scale >= 1:
			playerAudio.playerFuelAudio.pitch_scale -= 0.1
			
		if get_children().size() > 1:
			if fuel1.amount >= 3:
				fuel1.amount -= 1 
			fuel1.lifetime = 0.2
			if fuel2.amount >= 3:
				fuel2.amount -= 1 
			fuel2.lifetime = 0.2

	if  Input.is_action_pressed("turn_right"):
		dir_vector.x = 1

	if Input.is_action_pressed("turn_left"):
		dir_vector.x = -1
		
	if get_children().size() > 1:
		
		if Input.is_action_pressed("shoot") and coolDownTimer.is_stopped():
			playerAudio.playerFireAudioPlay()
			
			coolDownTimer.start(fireDelay)
			for child in weaponPositions.get_children():
				var bullet = pl_bullet.instantiate()
				bullet.global_position = child.global_position
				get_tree().current_scene.add_child(bullet)

			timeout=false
	
	velocity = dir_vector.normalized() * speed
	
	position += velocity * delta
	
	var viewRect = get_viewport_rect()
	
	position.x = clamp(position.x, 20, viewRect.size.x)
	position.y = clamp(position.y, 20, viewRect.size.y)
	
func _on_cool_down_timeout():
	timeout = true

func damage(amount):
	var activated = false
	
	
	if not invinsibilityTimer.is_stopped():
		activated = true
		return
	
	shieldField.monitoring = true
	shieldField.monitorable = true
	
	invinsibilityTimer.start(3)

	shield_activated.show()
	Signals.emit_signal('shieldActivation',activated)
	
	shipLife -= amount

	Signals.emit_signal('on_playerLife_changed',shipLife)
	Signals.emit_signal('shieldActivation',activated)
	playerAudio.playerShieldAudioPlay()
	
	var view = get_tree().current_scene.find_child("View",true,false)
	view.shake(3)
	
	if shipLife <= 0:
		playerAudio.playerDestructionAudioPlay()
		for child in get_children():
			if child != playerAudio:
				remove_child(child)
				child.queue_free()
		var effect = playerExplosion.instantiate()
		effect.position = position
		get_tree().current_scene.add_child(effect)
		
		playerAudio.playerFuelAudioStop()

func applyShield(time):
	
	var activated = false
	
	if not invinsibilityTimer.is_stopped():
		activated = true
		return
	
	playerAudio.playerShieldAudioPlay()
	
	invinsibilityTimer.start(time)

	shield_activated.show()
	Signals.emit_signal('shieldActivation',activated)
	
func applyRapidFire(time):
	fireDelay = rapidFireDelay
	rapidFireTimer.start(time + rapidFireTimer.time_left)
	
func _on_shield_activater_timeout():
	shieldField.monitoring = false
	shieldField.monitorable = false
	shield_activated.hide()
	
func player_state(state):

	if state:
		if fuel1.amount >= 3:
			fuel1.amount -= 1 
		fuel1.lifetime = 0.2
		if fuel2.amount >= 3:
			fuel2.amount -= 1 
		fuel2.lifetime = 0.2
	
func _on_rapid_fire_timer_timeout():
	fireDelay = normalFireDelay

func _on_shield_field_area_entered(area):
	area.queue_free()
