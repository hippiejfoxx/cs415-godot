extends Node2D


@onready var player = $Player
@onready var player_spawn = $PlayerSpawn
@onready var puck_container = $PuckContainer
@onready var whistle_container = $WhistleContainer
@onready var scoreboard = $Scoreboard

@onready var enemyGen = $EnemyGenerator
@onready var enemyCon = $EnemyContainer
@onready var playerDamage = $PlayerDamage

@onready var timeLabel = $GameTimeLabel
@onready var gameTimer = $GameTimer

@onready var endScreen = preload("res://EndScreen.tscn")

#@onready var goalie = $Goalie

#temp

# Called when the node enters the scene tree for the first time.
func _ready():
	ScoreScript.setPlayerScore(0)
	ScoreScript.setEnemyScore(0)
	player.global_position = player_spawn.global_position
	player.puck_shot.connect(_on_player_shot_puck)
	enemyGen.spawn.connect(_spawn)
	gameTimer.timeout.connect(load_end)
	gameTimer.start()
	
func load_end():
	ScoreScript.setPlayerScore(scoreboard.getPlayerScore())
	ScoreScript.setEnemyScore(scoreboard.getEnemyScore())
	get_tree().change_scene_to_packed(endScreen)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	timeLabel.text = str(gameTimer.time_left).split(".")[0].pad_zeros(2)
	if Input.is_action_just_pressed("quit"):
		get_tree().quit()

func _on_player_shot_puck(puck_scene, location):
	var puck = puck_scene.instantiate()
	puck.global_position = location
	puck.enemy_puck_hit_player.connect(_increase_enemy_score)
	puck_container.add_child(puck)
	
func _on_ref_shot_whistle(whistle, location):
	whistle.global_position = location
	whistle.enemy_scored.connect(_increase_enemy_score)
	whistle_container.add_child(whistle)
	
func _increase_player_score():
	scoreboard.IncreaseHome()
	
func _increase_enemy_score():
	playerDamage.play()
	scoreboard.IncreaseAway()
	
func _spawn(scene, location):
	var newScene = scene.instantiate()
	newScene.enemy_score.connect(_increase_enemy_score)
	newScene.destroyed_by_player.connect(_increase_player_score)
	newScene.playSound.connect(_playSound)
	newScene.global_position = location
	if newScene is Stripes:
		newScene.shoot_whistle.connect(_on_ref_shot_whistle)
	
	enemyCon.add_child(newScene)
	
func _playSound(sound):
	sound.play()
