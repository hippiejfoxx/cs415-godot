extends Node2D


var playerScore = 0
var enemyScore = 0

@onready var winnerLabel = $WinnerLabel
@onready var scoreLabel = $ScoreLabel

# Called when the node enters the scene tree for the first time.
func _ready():
	playerScore = ScoreScript.playerScore
	enemyScore = ScoreScript.enemyScore



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if enemyScore > playerScore:
		winnerLabel.text = "You lose"
	elif playerScore > enemyScore:
		winnerLabel.text = "You win!"
	else: 
		winnerLabel.text = "You tied"
	scoreLabel.text = str(playerScore) + " - " + str(enemyScore)


func _on_exit_pressed():
	get_tree().quit()


func _on_replay_pressed():
	get_tree().change_scene_to_file("res://Scenes/game.tscn")
