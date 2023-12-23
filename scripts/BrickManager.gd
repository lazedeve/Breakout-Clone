extends Node2D

var windowWidth = OS.get_window_size().x
var windowHeight = OS.get_window_size().y


onready var brickScene = preload("res://scenes/bricks.tscn")

var numberofbricks: int

export var topOffset: float = windowHeight / 9
export var horizontalGapBetweenBricks = 10
export var verticalGapBetweenBricks = 10

var brickColor = Color(0.78, 0.28, 0.28, 1)

var currentLevel
func _ready():
	randomize()
	add_bricks(1)

func add_bricks(level):
	
	var xBrickPosition = rand_range(windowWidth / 10, windowWidth / 10)
	var yBrickPosition = topOffset
	var z = 0
	
	var rowChanged = 0
	
	#numberofbricks = level*50*0.1
	numberofbricks = clamp(numberofbricks, 62, 62)
	
	var maxHorizontalSpace = windowWidth - xBrickPosition
	var maxVerticalSpace = (windowHeight / 2)
	
	#var brickSpace = Vector2(maxHorizontalSpace, maxVerticalSpace)
	
	#var maxHorizontalBricks: int = brickSpace.x / numberofbricks
	
	while numberofbricks > 0:
		
		var brickPosition = Vector2(xBrickPosition, yBrickPosition)
		
		var bricks = brickScene.instance()
		add_child(bricks)
		
		bricks.set_brick_position(brickPosition)
		bricks.set_brick_color(brickColor)
		
		xBrickPosition += bricks.brickWidth + horizontalGapBetweenBricks
		
		if xBrickPosition > maxHorizontalSpace:
			yBrickPosition += bricks.brickHeight + verticalGapBetweenBricks
			xBrickPosition = rand_range(windowWidth / 7, windowWidth / 4)
			rowChanged += 1
			change_color(rowChanged)
			maxHorizontalSpace = windowWidth - xBrickPosition
			
			if yBrickPosition > maxVerticalSpace:
				break
		
		numberofbricks -= 1


func change_color(rowChanged):
	if rowChanged == 0:
		brickColor = Color.red
	if rowChanged == 1:
		brickColor = Color.yellow
	if rowChanged == 2:
		brickColor = Color.green
	if rowChanged == 3:
		brickColor = Color.blue
	if rowChanged == 4:
		brickColor = Color.whitesmoke
