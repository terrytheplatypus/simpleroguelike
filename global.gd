extends Node


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var score = 0
var currLevel = 0
var playerHP=6
var initialHP = 6


# Called when the node enters the scene tree for the first time.
func _ready():
	var player = AudioStreamPlayer.new()
	player.stream= load("res://Molten_Slug.ogg")
	self.add_child(player)
	player.play()
	pass # Replace with function body.
func reset():
	playerHP= initialHP
	currLevel=0
func playPortal():
	var player = AudioStreamPlayer.new()
	player.stream= load("res://Portal.wav")
	self.add_child(player)
	player.play()


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
