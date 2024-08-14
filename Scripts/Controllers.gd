extends HBoxContainer

@onready var player = $"../../Player"

@onready var moveLeft = $VBoxContainer/HBoxContainer/MoveLeft
@onready var moveRight = $VBoxContainer/HBoxContainer/MoveRight
@onready var moveForward = $VBoxContainer/HBoxContainer2/MoveForward
@onready var shoot = $HBoxContainer/Shoot
@onready var launch = $HBoxContainer/Launch

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
