extends Area2D

@onready var p_bulletEffect = preload("res://Scenes/BulletScene/bullet_effect.tscn")

@export var speed:float = 25
@onready var missile = $Trace01
@onready var fuel = $Trace01/Fuel

func _process(delta):
	
	if Signals.globalScore <= 100 and Targets.steadyEnemyTargetPosition.y != 0:
		missile.look_at(Targets.steadyEnemyTargetPosition)
		missile.rotate(PI/2)
		if fuel.amount <= 6:
			fuel.amount += 1 
		fuel.lifetime = 0.25
		global_position.x = move_toward(global_position.x,Targets.steadyEnemyTargetPosition.x,delta*200)
		global_position.y = move_toward(global_position.y,Targets.steadyEnemyTargetPosition.y,delta*200)
		if Targets.steadyEnemyTargetPosition.y > global_position.y:
			global_position.y += speed
			if fuel.amount >= 3:
				fuel.amount -= 1 
			fuel.lifetime = 0.2
		
	elif Signals.globalScore >= 100 and Signals.globalScore <= 200:
		missile.look_at(Targets.bouncerEnemyTargetPosition)
		missile.rotate(PI/2)
		global_position.x = move_toward(global_position.x,Targets.bouncerEnemyTargetPosition.x,delta*200)
		global_position.y = move_toward(global_position.y,Targets.bouncerEnemyTargetPosition.y,delta*200)
		if Targets.bouncerEnemyTargetPosition.y > global_position.y:
			global_position.y += speed
	elif Signals.globalScore >= 200 :
		missile.look_at(Targets.fastEnemyTargetPosition)
		missile.rotate(PI/2)
		global_position.x = move_toward(global_position.x,Targets.fastEnemyTargetPosition.x,delta*200)
		global_position.y = move_toward(global_position.y,Targets.fastEnemyTargetPosition.y,delta*200)
		if Targets.fastEnemyTargetPosition.y > global_position.y:
			global_position.y += speed
	else:
		pass
	
func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()

func _on_area_entered(area):
	
	var bulletEffect = p_bulletEffect.instantiate()
	bulletEffect.position = position
	get_tree().current_scene.add_child(bulletEffect)
	
	var view = get_tree().current_scene.find_child("View",true,false)
	view.shake(3)
	
	if area.is_in_group('damagable'):
		area.damage(6)
	
	Signals.emit_signal("on_score_increment",6)
	Signals.scorePoint = 6
	
	queue_free()
