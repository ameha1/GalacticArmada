extends Enemy

@export var horizontalSpeed = 30
@export var bouncerspeed = 50

var horizontalDirection = 1

func _physics_process(delta):
	position.x += horizontalSpeed * delta * horizontalDirection
	
	var viewRect = get_viewport_rect()
	if position.x < viewRect.position.x or position.x > viewRect.end.x:
		horizontalDirection *= -1
	
	position.y += bouncerspeed * delta
	


