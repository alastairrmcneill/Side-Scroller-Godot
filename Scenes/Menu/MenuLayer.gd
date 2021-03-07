extends CanvasLayer

signal start_game
onready var startMenu = $StartMenu
onready var startLabel = $StartMenu/Label
onready var endMenu = $EndMenu
onready var scoreLabel = $EndMenu/VBoxContainer/ScoreLabel
onready var highScoreLabel = $EndMenu/VBoxContainer/HighScoreLabel
onready var tween = $Tween
onready var jumpButton = $Buttons/JumpButton
onready var slideButton = $Buttons/SlideButton

var gameStarted = false

func _ready():
	pass
	
func _input(event):
	if event.is_action_pressed("ui_accept") && !gameStarted:
		gameStarted = true 
		emit_signal("start_game")
		tween.interpolate_property(startLabel, "modulate:a", 1, 0, 0.2)
		tween.start()
		jumpButton.visible = true
		slideButton.visible = true
		
		
func init_game_over_menu(score, highScore):
	jumpButton.visible = false
	slideButton.visible = false
	
	scoreLabel.text = "Score: " + str(score)
	highScoreLabel.text = "High Score: " + str(highScore)
	endMenu.visible = true
	
func _on_RestartButton_pressed():
	get_tree().reload_current_scene()

