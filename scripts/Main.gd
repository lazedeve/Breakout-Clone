extends Node

onready var ballScene = preload("res://scenes/Ball.tscn")
onready var playerPaddleScene = preload("res://scenes/PlayerPaddle.tscn")
onready var brickManagerScene = preload("res://scenes/BrickManager.tscn")

var playerPaddle
var ball
var brickManager

func new_game():
	
	playerPaddle = playerPaddleScene.instance()
	ball = ballScene.instance()
	brickManager= brickManagerScene.instance()
	
	self.add_child(playerPaddle)
	self.add_child(ball)
	self.add_child(brickManager)
	
	$Ball.connect("outOfBounds", self, "game_over")


func game_over():
	playerPaddle.queue_free()
	ball.queue_free()
	brickManager.queue_free()
	$Button.show()

func _on_Button_pressed():
	new_game()
	$Button.hide()
