class_name Puck extends Area2D

@export var SPEED = 600

@export var direction = -1 #-1 down the screen. 1 up the screen

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
	if !(area is Goalie):
		queue_free()
		
func blocked():
	direction = 1
