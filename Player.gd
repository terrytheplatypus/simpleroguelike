extends KinematicBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
const WALK_SPEED = 400
const ACCELERATION_PERC = 0.2
var keyNum = 0
var iFrames=80
var currIFrame=-1

var velocity = Vector2()
var framenum=0
var keyPlayer= AudioStreamPlayer.new()
var owPlayer= AudioStreamPlayer.new()
var portalPlayer= AudioStreamPlayer.new()
var owSound= preload("res://OW.wav")
var keySound= preload("res://key.wav")
var portalSound= preload("res://Portal.wav")

# Called when the node enters the scene tree for the first time.
func _ready():
	print("color is"+ str(self.modulate))
	self.add_child(keyPlayer)
	self.add_child(owPlayer)
	self.add_child(portalPlayer)
	portalPlayer.stream=portalSound
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
	keyPlayer.stream= keySound
	keyPlayer.play()
	
func areAllKeysCollected():
	if(keyNum>= get_parent().totalKeyNum):
		portalPlayer.play()
		get_node("/root/Global").playPortal()
		get_tree().reload_current_scene()

func decrementHP():
	print("decrement HP")
	var global = get_node("/root/Global")
	if(currIFrame<0):
		owPlayer.stream= owSound
		owPlayer.play()
		global.playerHP -= 1
		print("new HP is", get_node("/root/Global").playerHP)
		currIFrame=iFrames
	
		


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if(currIFrame>=0):
		currIFrame-=1
		self.modulate = Color(1, 1, 1, 0.5)
	else:
		self.modulate = Color(1, 1, 1, 1)
	if(get_node("/root/Global").playerHP<=0):
		#switch to gameover scene
		get_tree().change_scene("res://gameover.tscn")
	pass
