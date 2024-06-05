extends CPUParticles2D


func _ready():
	emitting = true
	
	if !emitting:
		queue_free()
