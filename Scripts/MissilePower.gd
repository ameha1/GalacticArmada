extends Area2D

func _physics_process(delta):
	var powerShieldSpeed = Signals.powerupSpeed
	position.y += powerShieldSpeed

func missile_launch(Player):
	Player.launch_missile()
	Player.missileLaunchTimer(12)

func _on_area_entered(area):
	if area is Player:
		
		missile_launch(area)
		queue_free()

func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()
