extends Area2D

@export var speed:float = 5
@onready var missile = $Trace01

func _process(delta):
	
	global_position.y -= speed
	missile.look_at(Targets.steadyEnemyTargetPosition)
	missile.rotate(PI/2)
	
	global_position.x = move_toward(global_position.x,Targets.steadyEnemyTargetPosition.x,delta*100)
	global_position.x = move_toward(global_position.x,Targets.bouncerEnemyTargetPosition.x,delta*100)
	global_position.x = move_toward(global_position.x,Targets.fastEnemyTargetPosition.x,delta*100)
	
	

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
