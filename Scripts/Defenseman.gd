extends Area2D

@export var SPEED = 800

signal destroyed_by_player()
signal enemy_score()
signal playSound()

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _physics_process(delta):
	global_position.y += delta * SPEED

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_visible_on_screen_notifier_2d_screen_exited():
	enemy_score.emit()
	queue_free()

func _on_body_entered(body):
	if body is Player:
		enemy_score.emit()
		queue_free()

