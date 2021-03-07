extends Node2D

onready var parallax = $ParallaxBackground

var startingSpeed = 30
var speed = startingSpeed
var counter = 0.0
var stopping = false
var stopCounter = 0

func _ready():
	set_process(false)


func _process(delta):
	parallax.scroll_offset.x -= speed * delta

	
func update_speed(increase):
	counter += increase
	if counter > 5:
		
		counter = 0 
		speed += 5
		
		
func stop():
	set_process(false)
