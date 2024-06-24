extends Node

@onready var EnemyHitAudio = $EnemyHitAudio
@onready var EnemyDestructionAudio = $EnemyDestructionAudio
@onready var EnemyFireAudio = $EnemyFireAudio

func enemyHitAudioPlay():
	EnemyHitAudio.play()

func enemyDestructionAudioPlay():
	EnemyDestructionAudio.play()
	
func enemyDFireAudioPlay():
	EnemyFireAudio.play()
