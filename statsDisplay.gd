extends RichTextLabel


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	clear()
	#HORRIBLE hacky garbage to get key number, only did it this way because im running
	#out of time
	add_text("HP:" + str(get_node("/root/Global").playerHP) +
	"KEYS: " + str(get_node("../../Node2D/TileMap/Actors/Player").keyNum) +"/" + 
	str(get_node("../../Node2D/TileMap/Actors").totalKeyNum))
	pass
