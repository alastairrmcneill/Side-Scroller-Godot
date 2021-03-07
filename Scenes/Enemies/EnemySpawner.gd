extends Node2D

signal enemy_created(e)

onready var timer = $Timer

var rhino = preload("res://Scenes/Enemies/Rhino.tscn")
var birds = preload("res://Scenes/Enemies/Birds.tscn")
var tree = preload("res://Scenes/Enemies/Tree.tscn")

func _ready():
	randomize()


func _on_Timer_timeout():
	var enemy 
	var x = randf()
	if x > 0.6:
		enemy = rhino.instance()
	elif x > 0.3:
		enemy = birds.instance()
	else: 
		enemy = tree.instance()
		
	add_child(enemy)
	emit_signal("enemy_created", enemy)
	
	random_time()
	
func start():
	random_time()
	timer.start()
	
func stop():
	timer.stop()
	
func random_time():
	var x = rand_range(0.2, 2)
	timer.wait_time =  1 + x
