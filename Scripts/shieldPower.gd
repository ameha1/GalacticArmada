class_name ShieldPower
extends Area2D

@export var powerShieldSpeed = 0.5

func _physics_process(delta):
	position.y += powerShieldSpeed

func applyPowerShield(Player):
	pass

func _on_area_entered(area):
	if area is Player:
		applyPowerShield(area)
		queue_free()

func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()

