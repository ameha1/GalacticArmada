extends Camera2D

@export var shakeBaseAmount = 1.0
@export var shakeDamping = 0.075

var shakeAmount = 0.0


func _process(delta):

	if shakeAmount > 0:
		position.x = randf_range(-shakeBaseAmount,shakeBaseAmount) * shakeAmount
		position.y = randf_range(-shakeBaseAmount,shakeBaseAmount) * shakeAmount
		
		shakeAmount = lerp(shakeAmount, 0.0, shakeDamping)
	else:
		position = Vector2(0,0)

func shake(magnitude):
	
	shakeAmount += magnitude
