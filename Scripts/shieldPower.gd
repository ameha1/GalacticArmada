class_name ShieldPower
extends Area2D

@export var powerShieldSpeed = 0.5
@export var shieldTime = 6

func _physics_process(delta):
	position.y += powerShieldSpeed
	pass

func applyPowerShield(Player):
	Player.applyShield(shieldTime)

func _on_area_entered(area):
	if area is Player:
		applyPowerShield(area)
		queue_free()

func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()
	
