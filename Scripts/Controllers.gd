extends Control

@onready var player = $"../../Player"

var move_right = false
var move_left = false

func _physics_process(delta):
	if move_right:
		player.move_left()
	if move_right:
		print('moveRight - ',move_right)
		player.move_right()
		

func _on_move_left_pressed():
	move_left = true

func _on_move_right_pressed():
	move_right = true

func _on_move_forward_pressed():
	player.move_forward()

func _on_shoot_pressed():
	player.shoot()

func _on_launch_pressed():
	player.launch_missile()

func _on_move_left_button_up():
	#move_left = false
	pass

func _on_move_right_button_up():
	#move_right = false
	pass
