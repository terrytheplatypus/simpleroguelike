extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	
	pass # Replace with function body.
	
func _input(event):
	if(event.is_action_pressed("restart")):
		get_node("/root/Global").reset()
		get_tree().change_scene("res://maze.tscn")

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
