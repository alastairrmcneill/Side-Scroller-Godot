extends Node2D

onready var enemySpawner = $EnemySpawner
onready var background = $Background
onready var player = $Player
onready var menuLayer = $MenuLayer
onready var scoreLabel = $ScoreLabel

const saveFilePath = "user://savedata.save"

var gameSpeed = 1.2
var score = 0
var highScore = 0

func _ready():
	load_high_score()
	gameSpeed = 1
	Engine.time_scale = gameSpeed

func increase_speed():	
	gameSpeed += 0.1
	Engine.time_scale = gameSpeed

func _on_MenuLayer_start_game():
	new_game()


func new_game():
	enemySpawner.start()
	background.set_process(true)
	player.start()
	
func game_over():
	enemySpawner.stop()
	background.stop()
	get_tree().call_group("enemyGroup", "set_physics_process", false)
	
	if score > highScore:
		highScore = score
		save_high_score()
		
	scoreLabel.visible = false
		
	menuLayer.init_game_over_menu(score, highScore)
	
func add_score():
	score += 1
	scoreLabel.text = str(score)
	scoreLabel.update()
	increase_speed()
	
func _on_Player_game_over():
	game_over()

func _on_EnemySpawner_enemy_created(e):
	e.connect("Score", self, "add_score")
	
func save_high_score():
	var saveData = File.new()
	saveData.open(saveFilePath, File.WRITE)
	saveData.store_var(highScore)
	saveData.close()
	print("saved data")
	
	
func load_high_score():
	var saveData = File.new()
	if saveData.file_exists(saveFilePath):
		saveData.open(saveFilePath, File.READ)
		highScore = saveData.get_var()
		saveData.close()
	
