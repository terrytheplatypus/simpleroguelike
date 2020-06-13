extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var mapHeight 
var mapLength
var cellSize

# Called when the node enters the scene tree for the first time.
func _ready():
	mapHeight = get_parent().mapHeight
	mapLength = get_parent().mapLength
	cellSize = get_parent().cellSize
	var player = preload("res://player.tscn").instance()
	#get_node("TileMap2").
	add_child(player)
	player.position=Vector2(30,30)
	print(get_parent().mapHeight)
	for n in range(4):
		var key = load("res://key.tscn").instance()
		add_child(key)
		key.position = get_parent().getRandPos()
		#
		#create keys
		pass
	#create exit
	var goal = load("res://goal.tscn").instance()
	add_child(goal)
	goal.position = get_parent().getRandPos()
	pass # Replace with function body.
	#add p

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
