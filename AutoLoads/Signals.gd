extends Node

signal on_playerLife_changed(life)

signal shieldActivation(activated)

signal on_score_increment(amount)

signal openingScene_notifier(state)

signal playerBulletPosition(position)

var playerScores = [0]

var powerupSpeed
var enemySpeed
var globalScore
var missileLeft = 100
var scorePoint

var scoreRecord_res = "res://scoreRecord.txt"
var scoreFile_W = FileAccess.open(scoreRecord_res,FileAccess.WRITE)
var scoreFile_R = FileAccess.open(scoreRecord_res,FileAccess.READ)

