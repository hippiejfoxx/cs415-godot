extends Node

@onready var homeScore = $HomeScore
@onready var awayScore = $AwayScore

@onready var home = 0
@onready var away = 0


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func getPlayerScore():
	return home
	
func getEnemyScore():
	return away

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	homeScore.text = str(home)
	awayScore.text = str(away)

func IncreaseHome():
	home += 1
	
func IncreaseAway():
	away += 1
