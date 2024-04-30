extends Area2D

@export var SPEED = 450

@onready var goalSound = $GoalMade
@onready var life = 2

signal destroyed_by_player()
signal playSound(soundToPlay)
signal enemy_score()

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _physics_process(delta):
	global_position.y += delta * SPEED
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_area_entered(area):
	if area is Puck:
		playSound.emit(goalSound)
		life -= 1
		if life <= 0:
			destroyed_by_player.emit()
			queue_free()

func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()


func _on_body_entered(body):
	if body is Player:
		enemy_score.emit()
		queue_free()
