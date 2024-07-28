extends Area2D

@export var speed:float = 8

func _process(delta):
	#print('Target_Position - ',Targets.steadyEnemyTargetPosition)
	
	global_position.y -= speed


func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()

func _on_area_entered(area):
	
	#var bulletEffect = p_bulletEffect.instantiate()
	#bulletEffect.position = position
	#get_tree().current_scene.add_child(bulletEffect)
	
	#var view = get_tree().current_scene.find_child("View",true,false)
	#view.shake(3)
	
	if area.is_in_group('damagable'):
		area.damage(6)
	
	queue_free()
