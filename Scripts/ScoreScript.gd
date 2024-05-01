extends Node

var playerScore = 0
var enemyScore = 0

func setPlayerScore(score):
	playerScore = score
	
func setEnemyScore(score):
	enemyScore = score

func getPlayerScore(score):
	return playerScore
	
func getEnemyScore(score):
	return enemyScore
