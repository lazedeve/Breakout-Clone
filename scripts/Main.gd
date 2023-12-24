extends Node

onready var ballScene = preload("res://scenes/Ball.tscn")
onready var playerPaddleScene = preload("res://scenes/PlayerPaddle.tscn")
onready var brickManagerScene = preload("res://scenes/BrickManager.tscn")

var playerPaddle
var ball
var brickManager

var health = 3
var score = 0
var level = 1

func _ready():
	$HUD.connect("new_game", self, "new_game")
	self.set_physics_process(false)


func _physics_process(delta):
	if brickManager.brickCounter == 0:
		next_level()

func new_game():
	
	self.set_physics_process(true)
	score = 0
	$HUD/ScoreLabel.text = str(score)
	
	paddleSpawn()
	ball_spawn()
	bricks_spawn()


func paddleSpawn():
	playerPaddle = playerPaddleScene.instance()
	self.add_child(playerPaddle)

func ball_spawn():
	ball = ballScene.instance()
	self.add_child(ball)
	ball.connect("outOfBounds", self, "health_changed")
	ball.connect("scored", self, "score_counter")

func bricks_spawn():
	brickManager= brickManagerScene.instance()
	self.add_child(brickManager)
	brickManager.add_bricks(level)

func next_level():
	self.set_physics_process(false)
	reset_position()
	brickManager.queue_free()
	level += 1
	bricks_spawn()


func health_changed():
	health -= 1
	$HUD/Health.text = str(health)
	reset_position()
	if health == 0:
		game_over()


func reset_position():
	playerPaddle.queue_free()
	ball.queue_free()
	paddleSpawn()
	ball_spawn()


func game_over():
	self.set_physics_process(false)
	playerPaddle.queue_free()
	ball.queue_free()
	brickManager.queue_free()
	$HUD/Play.show()
	$HUD/Title.text = "Game Over!"
	$HUD/Title.show()
	level = 1
	health = 3


func score_counter():
	score += 1
	brickManager.brickCounter -= 1
	$HUD/ScoreLabel.text = str(score)
