extends VisibilityNotifier2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if(is_on_screen()):
		get_node("enemyController").setOnScreen()
	else:
		get_node("enemyController").setOffScreen()
	pass
