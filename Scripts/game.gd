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

#@onready var goalie = $Goalie

#temp
@onready var ref = $Ref

# Called when the node enters the scene tree for the first time.
func _ready():
	player.global_position = player_spawn.global_position
	player.puck_shot.connect(_on_player_shot_puck)
	#temp
	ref.shoot_whistle.connect(_on_ref_shot_whistle)
	enemyGen.spawn.connect(_spawn)
	gameTimer.start()
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	timeLabel.text = str(gameTimer.time_left).substr(0,2)
	if Input.is_action_just_pressed("quit"):
		get_tree().quit()

func _on_player_shot_puck(puck_scene, location):
	var puck = puck_scene.instantiate()
	puck.global_position = location
	puck_container.add_child(puck)
	
func _on_ref_shot_whistle(whistle, location):
	whistle.global_position = location
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
	enemyCon.add_child(newScene)
	
func _playSound(sound):
	sound.play()
