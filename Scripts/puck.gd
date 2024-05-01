class_name Puck extends Area2D

@export var SPEED = 600

@export var direction = -1 #-1 down the screen. 1 up the screen

signal enemy_puck_hit_player()

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _physics_process(delta):
	global_position.y += direction * SPEED * delta

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()

func _on_area_entered(area):
	print("Area" + str(area))
	if !(area is Goalie):
		queue_free()
		
		
func blocked():
	direction = 1
	collision_mask = 1


func _on_body_entered(body):
	if body is Player and direction == 1:
		enemy_puck_hit_player.emit()
		queue_free()
