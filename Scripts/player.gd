extends Area2D

class_name Player

var pl_bullet = preload("res://Scenes/BulletScene/bullet.tscn")
var pl_missile = preload("res://Scenes/MissileScene/missile.tscn")
var playerExplosion = preload("res://Scenes/PlayerScene/player_explosion.tscn")

@onready var speed = 200

var velocity = Vector2(0,0)

@onready var weaponPositions = $WeaponPositions
@onready var missilePosition = $MissilePosition
@onready var shield_activated = $shield
@onready var invinsibilityTimer = $InvisibilityTimer
@onready var shieldField = $shield/shieldField
@onready var coolDownTimer = $CoolDown
@onready var rapidFireTimer = $RapidFireTimer
@onready var fuel1 = $Fuel
@onready var fuel2 = $Fuel2
@onready var missileLauncher = $MissileLauncher
@onready var HUD = $"../CanvasLayer/HUD"

@onready var playerAudio = $PlayerAudio

@export var normalFireDelay = 0.2
@export var rapidFireDelay = 0.08
var fireDelay = normalFireDelay

var timeout = false
var launchMode = false
@export var shipLife = 3


var dir_vector = Vector2()

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
	dir_vector = Vector2(0,0)
	rotation = 0
	
	if Input.is_action_just_pressed("accelerate"):
		move_forward()
	
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
		move_right()
	
	if Input.is_action_pressed("turn_left"):
		move_left()
	
	if get_children().size() > 1:
		
		if Input.is_action_pressed("shoot") and coolDownTimer.is_stopped():
			shoot()
	
	launch_activation()
	
	#velocity = dir_vector.normalized() * speed
	#
	#position += velocity * delta
	
	var viewRect = get_viewport_rect()
	
	position.x = clamp(position.x, 40, viewRect.size.x-50)
	position.y = clamp(position.y, 20, viewRect.size.y)
	
func _on_cool_down_timeout():
	timeout = true

func damage(amount):
	shieldField.monitoring = true
	shieldField.monitorable = true
	
	var activated = false
	
	if not invinsibilityTimer.is_stopped():
		activated = true
		return
	
	invinsibilityTimer.start(3)

	shield_activated.show()
	Signals.emit_signal('shieldActivation',activated)
	
	shipLife -= amount

	Signals.emit_signal('on_playerLife_changed',shipLife)
	Signals.emit_signal('shieldActivation',activated)
	playerAudio.playerShieldAudioPlay()
	
	var view = get_tree().current_scene.find_child("View",true,false)
	view.shake(4)
	
	if shipLife <= 0:
		playerAudio.playerDestructionAudioPlay()
		for child in get_children():
			if child != playerAudio:
				remove_child(child)
				child.queue_free()
		var effect = playerExplosion.instantiate()
		effect.position = position
		get_tree().current_scene.add_child(effect)
		
		launchMode = false
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

func launch_missile():
	launchMode = true
	
	if Signals.missileLeft <= 0 and Input.is_action_just_pressed("launch"):
		HUD.low_missileSupply()
		launchMode = false
	
	if Signals.missileLeft > 0 and Input.is_action_pressed("launch"):
		
		if coolDownTimer.is_stopped(): 
			
			coolDownTimer.start(3)
			
			playerAudio.playerMissileLaunchAudioPlay()
			
			for child in missilePosition.get_children():
				
				var bullet = pl_missile.instantiate()
				
				bullet.global_position = child.global_position
				
				get_tree().current_scene.add_child(bullet)
				
				Signals.missileLeft -= 1
				
				timeout=false

func launch_activation():
	if launchMode:
		launch_missile()

func _on_rapid_fire_timer_timeout():
	fireDelay = normalFireDelay

func _on_shield_field_area_entered(area):
	area.queue_free()
	
func RecordPlayerScores(score):
	Signals.playerScores.append(score)

func bestScoreRtrn():
	return Signals.playerScores.max()

func _on_missile_launcher_timeout():
	launchMode = true

func move_forward():
	if playerAudio.playerFuelAudio.pitch_scale <= 3:
		playerAudio.playerFuelAudio.pitch_scale += 0.1
		
	if get_children().size() > 1:
		if fuel1.amount <= 6:
			fuel1.amount += 1 
		fuel1.lifetime = 0.25
		if fuel2.amount <= 6:
			fuel2.amount += 1 
			fuel2.lifetime = 0.25
	
func move_right():
	dir_vector.x = 1
	
	velocity = dir_vector.normalized() * speed
	position += velocity * 0.01666666666667
	
func move_left():
	dir_vector.x = -1
	
	velocity = dir_vector.normalized() * speed
	position += velocity * 0.01666666666667

func shoot():
	playerAudio.playerFireAudioPlay()
	
	if coolDownTimer.is_stopped():
			
		coolDownTimer.start(fireDelay)
		
		for child in weaponPositions.get_children():
			var bullet = pl_bullet.instantiate()
					
			bullet.global_position = child.global_position
					
			get_tree().current_scene.add_child(bullet)
					
		timeout=false
