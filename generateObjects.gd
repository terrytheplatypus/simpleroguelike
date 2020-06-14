extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var mapHeight 
var mapLength
var cellSize
var totalKeyNum
var enemyNum
var player = preload("res://player.tscn").instance()
var key =preload("res://key.tscn")
var goal = preload("res://goal.tscn")
var enemy = preload("res://dumbEnemy.tscn")


# Called when the node enters the scene tree for the first time.
func _ready():
	mapHeight = get_parent().mapHeight
	mapLength = get_parent().mapLength
	cellSize = get_parent().cellSize
	totalKeyNum=mapHeight*mapLength/5
	enemyNum = floor(mapHeight*mapLength/3)
	
	#get_node("TileMap2").
	add_child(player)
	player.position=get_parent().getRandPos()
	print(get_parent().mapHeight)
	for n in range(totalKeyNum):
		var keyInstance = key.instance()
		add_child(keyInstance)
		keyInstance.position = get_parent().getRandPos()
		pass
	#create exit
	var goalInstance = goal.instance()
	add_child(goalInstance)
	goalInstance.position = get_parent().getRandPos()
	#create enemy
	for i in range(enemyNum):
		var enemyInstance = enemy.instance()
		add_child(enemyInstance)
		enemyInstance.position = get_parent().getRandPos()
	pass # Replace with function body.
	#add p

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
