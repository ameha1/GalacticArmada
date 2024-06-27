extends Node

@onready var meteorHitAudio = $MeteorHitAudio
@onready var meteorDestructionAudio = $MeteorDestructionAudio

func meteorHitAudioPlay():
	meteorHitAudio.play()

func meteorDestructiomAudioPlay():
	meteorDestructionAudio.play()

