extends Enemy

signal Score

onready var animation = $AnimationPlayer

func _ready():
	animation.play("Idle")


func _on_Birds_body_entered(body):
	if body is Player:
		if body.has_method("die"):
			body.die()

func _on_ScoreArea_body_exited(body):
	if body is Player:
		if body.state != body.states.Dead:
			emit_signal("Score")
