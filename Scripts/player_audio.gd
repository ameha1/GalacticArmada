extends Node

@onready var playerFireAudio = $playerFireAudio
@onready var playerShieldAudio = $playerShieldAudio
@onready var playerFuelAudio = $playerFuelAudio
@onready var playerDestructionAudio = $playerFireAudio

func playerFireAudioPlay():
	playerFireAudio.play()
	
func playerShieldAudioPlay():
	playerShieldAudio.play()
	
func playerFuelAudioPlay():
	playerFuelAudio.play()

func playerDestructionAudioPlay():
	playerDestructionAudio.play()
