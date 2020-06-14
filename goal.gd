extends Area2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	connect("body_entered", self,'playerEnter')
	pass # Replace with function body.

func playerEnter(body):
	print(body.get_name()+ "entered area")
	if(body.get_name()=="Player"):
		body.areAllKeysCollected()
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
