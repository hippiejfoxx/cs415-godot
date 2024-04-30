extends Node2D


@onready var player = $Player
@onready var player_spawn = $PlayerSpawn
@onready var puck_container = $PuckContainer
@onready var whistle_container = $WhistleContainer
@onready var scoreboard = $Scoreboard

@onready var goalie = $Goalie

#temp
@onready var ref = $Ref

# Called when the node enters the scene tree for the first time.
func _ready():
	player.global_position = player_spawn.global_position
	player.puck_shot.connect(_on_player_shot_puck)
	#temp
	ref.shoot_whistle.connect(_on_ref_shot_whistle)
	goalie.destroyed_by_player.connect(_increase_player_score)
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("quit"):
		get_tree().quit()
	elif Input.is_action_just_pressed("reset"):
		get_tree().reload_current_scene()

func _on_player_shot_puck(puck_scene, location):
	var puck = puck_scene.instantiate()
	puck.global_position = location
	puck_container.add_child(puck)
	
func _on_ref_shot_whistle(whistle, location):
	whistle.global_position = location
	whistle_container.add_child(whistle)
	
func _increase_player_score():
	scoreboard.IncreaseHome()
