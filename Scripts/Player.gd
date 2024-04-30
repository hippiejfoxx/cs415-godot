class_name Player extends CharacterBody2D

signal puck_shot(puck_scene, location)
@export var SPEED = 300.0
@export var RATE_OF_FIRE := 0.50

@onready var shot_start = $ShotStart
@onready var shotSound = $ShotSound

var puck_scene = preload("res://Scenes/puck.tscn")

var shoot_cd := false

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func _process(delta):
	if Input.is_action_pressed("shoot"):
		if !shoot_cd:
			shoot_cd = true
			shoot()
			await get_tree().create_timer(RATE_OF_FIRE).timeout
			shoot_cd = false

func _physics_process(delta):

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Vector2(Input.get_axis("moveleft","moveright"), Input.get_axis("moveup", "movedown"))
	direction = direction.normalized()
	velocity = direction * SPEED
	move_and_slide()

	position.x = clamp(position.x, 0, get_viewport().size.x-40)
	position.y = clamp(position.y, 0, get_viewport().size.y-40)
	
func shoot():
	shotSound.play()
	puck_shot.emit(puck_scene, shot_start.global_position)
	
