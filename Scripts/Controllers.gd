extends Control

@onready var player = $"../../Player"

@onready var moveLeft = $MoveLeft
@onready var moveRight = $MoveRight
@onready var moveForward = $MoveForward
@onready var shoot = $Shoot
@onready var launch = $Launch

func _physics_process(delta):
	
	if moveLeft.button_pressed:
		player.move_left()
	if moveRight.button_pressed:
		player.move_right()
	if moveForward.button_pressed:
		player.move_forward()
	if shoot.button_pressed:
		player.shoot()
	if launch.button_pressed:
		if Signals.missileLeft > 0:
			player.launchMode = true
			player.launch_activation()
