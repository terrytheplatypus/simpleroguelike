extends KinematicBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
const WALK_SPEED = 400
const ACCELERATION_PERC = 0.2
var keyNum = 0

var velocity = Vector2()
var framenum=0

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.
	
func _physics_process(delta):
	framenum+=1
	# where does the player WANT to move?
	var move_vec:Vector2 = Vector2(Input.get_action_strength("move_right") - Input.get_action_strength("move_left"), Input.get_action_strength("move_down") - Input.get_action_strength("move_up"))
	move_vec = move_vec.normalized() # only 1 in every direction, even diagonals
	move_vec *= WALK_SPEED
	
	velocity = lerp(velocity, move_vec, ACCELERATION_PERC)
	
	var collision = move_and_slide(velocity)
	
	
	#if collided with a key increment key number
func incrementKeyNum():
	keyNum+=1
	
func areAllKeysCollected():
	if(keyNum>=4):
		get_tree().reload_current_scene()



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	#
	pass
