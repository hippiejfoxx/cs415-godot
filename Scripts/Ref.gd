class_name Stripes extends Area2D


@export var SPEED = 100

@onready var shot_start = $WhistleStart
@onready var whistle_scene = preload("res://Scenes/whistle.tscn")
@onready var whistleSound = $WhistleSound
@export var RATE_OF_FIRE := 1

signal shoot_whistle(whistle, location)
signal enemy_score()
signal destroyed_by_player()
signal playSound()

var shoot_cd := false



func _physics_process(delta):
	global_position.y += delta * SPEED

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if !shoot_cd:
		shoot_cd = true
		shoot()
		await get_tree().create_timer(RATE_OF_FIRE).timeout
		shoot_cd = false

func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()

func shoot():
	var lw = whistle_scene.instantiate()
	lw.Direction = -1;
	var rw = whistle_scene.instantiate()
	rw.Direction = 1
	var w = whistle_scene.instantiate();
	shoot_whistle.emit(w, shot_start.global_position)
	shoot_whistle.emit(rw, shot_start.global_position)
	shoot_whistle.emit(lw, shot_start.global_position)
	
func _on_body_entered(body):
	if body is Player:
		enemy_score.emit()
		queue_free()
		
func _on_area_entered(area):
	if area is Puck:
		destroyed_by_player.emit()
		queue_free()

func _on_visible_on_screen_notifier_2d_screen_entered():
	whistleSound.play()
