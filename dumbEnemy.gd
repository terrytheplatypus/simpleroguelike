extends KinematicBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var hp = 3
var currFrame=0
var velocity=Vector2()
var moveVec=Vector2()
const WALK_SPEED = 5
var isOnScreen=false
var boingSound= preload("res://boing.wav")
var players = [AudioStreamPlayer.new(),
				AudioStreamPlayer.new(),
				AudioStreamPlayer.new(),
				AudioStreamPlayer.new()]
var currPlayer= 0

# Called when the node enters the scene tree for the first time.
func _ready():
	#add players as child
	for p in players:
		self.add_child(p)
	pass # Replace with function body.
func _physics_process(delta):
	
	if(currFrame%120==0):
		#print("move enemy")
		randomize()
		var x =(randi()%40-1)
		var y =(randi()%40-1)
		moveVec = Vector2(x,y).normalized()*WALK_SPEED
		
	velocity = lerp(velocity, moveVec, .04)
	var coll = move_and_collide(velocity, false)
	if(coll):
		#print("collide enemy")
		moveVec=coll.normal.normalized().reflect(moveVec.normalized())*WALK_SPEED
		#if on screen play boing.ogg
		if(isOnScreen):
			#self.add_child(player)
			#not sure if this is necessary but it seems like it'd be faster
			#to allocate players beforehand
			players[currPlayer].stream= boingSound
			players[currPlayer].play()
			currPlayer=(currPlayer+1)%players.size()
			#player.queue_free()
		velocity=Vector2(0,0)
	currFrame+=1
	pass
	
#not a necessary function but whatever
func setOnScreen():
	#print("setOnScreen")
	isOnScreen=true

func setOffScreen():
	#print("setOffScreen")
	isOnScreen=false
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

