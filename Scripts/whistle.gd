extends Area2D


@export var SPEED = 400


signal enemy_scored()
#-1 left 
#0 straight
#1 right
@export var Direction = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _physics_process(delta):
	global_position.y += delta * SPEED
	global_position.x += delta * SPEED * (Direction * 0.3 )

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_body_entered(body):
	if body is Player:
		enemy_scored.emit()
		queue_free()
