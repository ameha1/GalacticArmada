extends ShieldPower

@export var shieldTime = 6

func applyPowerShield(Player):
	
	Player.applyShield(shieldTime)
	print('appylShield !')
	
