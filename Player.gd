extends KinematicBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
const WALK_SPEED = 600

var velocity = Vector2()

# Called when the node enters the scene tree for the first time.
func _ready():
	position=Vector2(2450, 2450)
	#position=Vector2(0, 0)
	pass # Replace with function body.
	
func _physics_process(delta):
	if Input.is_action_pressed("ui_left"):
		velocity.x = -WALK_SPEED
	elif Input.is_action_pressed("ui_right"):
		velocity.x =  WALK_SPEED
	elif Input.is_action_pressed("ui_up"):
		velocity.y =  -WALK_SPEED
	elif Input.is_action_pressed("ui_down"):
		velocity.y =  WALK_SPEED
	else:
		velocity.x = 0
	move_and_slide(velocity, Vector2(0, -1))
	
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
