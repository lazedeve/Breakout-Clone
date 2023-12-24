extends Node2D

var windowWidth = OS.get_window_size().x
var windowHeight = OS.get_window_size().y

var brickClass = BrickData.new()

var brickWidth = brickClass.brickWidth
var brickHeight = brickClass.brickHeight

onready var brickScene = preload("res://scenes/bricks.tscn")

var numberofbricks: int

export var topOffset: float = windowHeight / 9
export var horizontalGapBetweenBricks = 5
export var verticalGapBetweenBricks = 5

var brickColor = Color(0.78, 0.28, 0.28, 1)

var borderThickness = 10

var currentLevel

var brickCounter = 1

var leftEdge = borderThickness
var rightEdge = windowWidth - borderThickness
var playeAreaWidth = rightEdge - leftEdge
var maxPlayHeight = windowHeight / 2


func _ready():
	randomize()


func add_bricks(level):
	
	numberofbricks = 60 * level * 0.1
	numberofbricks = clamp(numberofbricks, 60, 200)
	
	var minBrickPositionX = leftEdge
	#var maxBrickPositionX = rightEdge - brickWidth
	
	var xBrickPosition = rand_range(minBrickPositionX, 6 * brickWidth)
	var yBrickPosition = topOffset
	
	var firstBrickGap = xBrickPosition - leftEdge
	
	var rowChanged = 0
	while numberofbricks > -1:
		
		var brickPosition = Vector2(xBrickPosition, yBrickPosition)
		
		var bricks = brickScene.instance()
		add_child(bricks)
		
		bricks.set_brick_position(brickPosition)
		bricks.set_brick_color(brickColor)
		
		xBrickPosition += brickWidth + horizontalGapBetweenBricks
		
		if xBrickPosition + brickWidth >= rightEdge - firstBrickGap:
			yBrickPosition += brickHeight + verticalGapBetweenBricks
			xBrickPosition = rand_range(minBrickPositionX, 6 * brickWidth)
			firstBrickGap = xBrickPosition - leftEdge
			rowChanged += 1
			change_color(rowChanged)
			
		if numberofbricks <= 1 and xBrickPosition + brickWidth < rightEdge - firstBrickGap:
			numberofbricks += (xBrickPosition + brickWidth) / brickWidth
			maxPlayHeight = yBrickPosition + brickHeight
		if yBrickPosition >= maxPlayHeight:
			break
			
		numberofbricks -= 1
		brickCounter += 1
	
	print(brickCounter)



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
	if rowChanged > 4:
		var r = rand_range(0, 1)
		var g = rand_range(0, 1)
		var b = rand_range(0, 1)
		brickColor = Color(r, g, b, 1)
