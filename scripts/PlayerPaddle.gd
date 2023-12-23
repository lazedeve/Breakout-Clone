extends KinematicBody2D

var windowWidth = OS.get_window_size().x
var windowHeight = OS.get_window_size().y

var halfWindowWidth = windowWidth / 2
var halfWindowHeight = windowHeight / 2

export var paddleWidth: float = 50
export var paddleHeight: float = 15

var paddleHalfWidth = paddleWidth / 2
var paddleHalfHeight = paddleHeight / 2

export var bottomOffset = 50
var paddlePosition = Vector2(halfWindowWidth, windowHeight - bottomOffset)

var paddleShape
var paddleVertices

var paddleSpeed = 500
var velocity = Vector2.ZERO

func _ready():
	create_paddle()

func _physics_process(delta):
	var direction = get_input().normalized()
	velocity = paddleSpeed * direction
	move_and_slide(velocity)

func get_input():
	var input = Vector2.ZERO
	if Input.is_key_pressed(KEY_D):
		input.x = 1
	if Input.is_key_pressed(KEY_A):
		input.x = -1
	
	return input



func create_paddle():
	paddleShape = Polygon2D.new()
	paddleVertices = PoolVector2Array()
	
	paddleVertices.push_back(Vector2(paddlePosition.x - paddleHalfWidth, paddlePosition.y))
	paddleVertices.push_back(Vector2(paddlePosition.x - paddleHalfWidth, paddlePosition.y + paddleHeight))
	paddleVertices.push_back(Vector2(paddlePosition.x + paddleWidth, paddlePosition.y + paddleHeight))
	paddleVertices.push_back(Vector2(paddlePosition.x + paddleWidth, paddlePosition.y))
	
	paddleShape.set_polygon(paddleVertices)
	paddleShape.set_color(Color.white)
	self.add_child(paddleShape, true)
	paddleCollisionPolygon()

func paddleCollisionPolygon():
	var paddleCollision = CollisionPolygon2D.new()
	
	paddleCollision.set_polygon(paddleVertices)
	self.add_child(paddleCollision, true)
	
