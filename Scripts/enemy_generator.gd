extends Node2D

var margin = 50
var screen_width = ProjectSettings.get_setting("display/window/size/viewport_width")

@onready var goalieTimer = $GoalieSpawner
@onready var goalie = preload("res://Scenes/goalie.tscn")
@onready var goal = preload("res://Scenes/goal.tscn")
@onready var ref = preload("res://Scenes/ref.tscn")
@onready var dMan = preload("res://Scenes/defenseman.tscn")

@onready var goalTimer = $GoalTimer
@onready var refTimer = $RefTimer
@onready var dTimer = $DTimer
signal spawn(preload_asset, location)

# Called when the node enters the scene tree for the first time.
func _ready():
	goalieTimer.timeout.connect(handle_spawn.bind(goalie, goalieTimer))
	goalTimer.timeout.connect(handle_spawn.bind(goal, goalTimer))
	refTimer.timeout.connect(handle_spawn.bind(ref, refTimer))
	dTimer.timeout.connect(handle_spawn.bind(dMan, dTimer))
	goalieTimer.start()
	goalTimer.start()
	refTimer.start()
	dTimer.start()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func handle_spawn(scene, timer):
	
	var location = Vector2(randf_range(margin, screen_width-margin), -16)
	spawn.emit(scene, location)
