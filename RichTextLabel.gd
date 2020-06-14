extends RichTextLabel


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	add_text("GAMER OVER: You completed " + str(get_node("/root/Global").currLevel-1)+ " levels.\n"
	+"Press R to restart")
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
