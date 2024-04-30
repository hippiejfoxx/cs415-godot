class_name Goalie extends Area2D


@export var SPEED = 300
signal destroyed_by_player()

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _physics_process(delta):
	global_position.y += delta * SPEED

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()

func die():
	queue_free()

	
func _on_damage_area_area_entered(area):
	if area is Puck:
		queue_free()
		destroyed_by_player.emit()


func _on_absorb_area_area_entered(area):
	if area is Puck:
		area.blocked()
	
func _on_body_entered(body):
	queue_free()
