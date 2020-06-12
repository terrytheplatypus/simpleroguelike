extends TileMap


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	var player = preload("res://player.tscn").instance()
	#get_node("TileMap2").
	add_child(player)
	player.position=Vector2(30,30)
	print(get_parent().mapHeight)
	pass # Replace with function body.
	#add p

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
