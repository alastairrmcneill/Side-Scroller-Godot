extends Area2D
class_name Enemy


var speed = -210


func _ready():
	pass
	
func _physics_process(delta):
	position.x += speed * delta
	if global_position.x < -100:
		queue_free()
		

