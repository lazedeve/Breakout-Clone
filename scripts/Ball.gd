extends KinematicBody2D

var windowWidth = OS.get_window_size().x
var windowHeight = OS.get_window_size().y

var halfWindowWidth = windowWidth / 2
var halfWindowHeight = windowHeight / 2

export var ballRadius = 8

export var ballTotalVertices = 50

var theta

var ballOrigin = Vector2(halfWindowWidth, halfWindowHeight + 200)

var xVertice
var yVertice

var velocity = Vector2(10, 100)
var speed
var direction

func _ready():
	create_ball()

func create_ball():
	var ballShape = Polygon2D.new()
	var ballVertices = PoolVector2Array()
	
	theta = 0
	
	while ballTotalVertices > 0:
		xVertice = ballRadius * cos(theta) + ballOrigin.x
		yVertice = ballRadius * sin(theta) + ballOrigin.y
		var ballVertice = Vector2(xVertice, yVertice)
		ballVertices.push_back(ballVertice)
		theta += 0.125664
		ballTotalVertices -= 1
	
	ballShape.set_polygon(ballVertices)
	ballShape.set_color(Color.white)
	self.add_child(ballShape, true)
	
	var ballCollisionShape = CollisionPolygon2D.new()
	ballCollisionShape.set_polygon(ballVertices)
	self.add_child(ballCollisionShape, true)

func _physics_process(delta):
	var collision_info = move_and_collide(velocity * delta)
	if collision_info:
		velocity = velocity.bounce(collision_info.normal)
		if collision_info.collider.is_in_group("bricks"):
			velocity = velocity.bounce(collision_info.normal)
			collision_info.collider.queue_free()
	
