extends RigidBody2D
class_name Player

signal died
signal game_over

const jumpForce = -600

var alive = true
var started = false
enum states {Idle, Run, Jump, Slide, Dead, Game_over}
var state = states.Idle

onready var animation = $AnimationPlayer
onready var timer = $SlideTimer


func _ready():
	pass


func _physics_process(delta):
	match state:

		states.Run:
			if Input.is_action_just_pressed("ui_up") && alive && started:
				jump()
				
			if Input.is_action_just_pressed("ui_down") && alive && started:
				slide()
			
		states.Jump:
			pass
			
		states.Slide:
			if Input.is_action_just_released("ui_down") && alive && started:
				state = states.Run
				animation.stop()
				animation.play("Run")
				
		states.Dead:
			if !animation.is_playing():
				emit_signal("game_over")
				state = states.Game_over
				
		states.Game_over:
			pass


func start():
	started = true
	state = states.Run
	animation.stop()
	animation.play("Run")

func jump():
	state = states.Jump
	linear_velocity.y = jumpForce
	animation.stop()
	animation.play("Jump")
	
func slide():
	state = states.Slide
	timer.start()
	animation.stop()
	animation.play("Slide")
	
func die():
	if !alive: return
	alive = false
	emit_signal("died")
	state = states.Dead
	animation.play("Dead")
	
	

func _on_Player_body_entered(body):
	if body is StaticBody2D:
		if state == states.Jump:
			state = states.Run
			animation.stop()
			animation.play("Run")
			
func _on_SlideTimer_timeout():
	if state == states.Slide:
		state = states.Run
		animation.stop()
		animation.play("Run")
