extends Node

signal on_playerLife_changed(life)

signal shieldActivation(activated)

signal on_score_increment(amount)

signal openingScene_notifier(state)

signal playerBulletPosition(position)

var playerScores = [0]
