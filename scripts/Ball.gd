class_name Ball
extends KinematicBody2D

signal outOfBounds
signal scored

var windowWidth = OS.get_window_size().x
var windowHeight = OS.get_window_size().y

var halfWindowWidth = windowWidth / 2
var halfWindowHeight = windowHeight / 2

export var ballRadius = 7

export var ballTotalVertices = 50

var theta

var ballOrigin = Vector2(halfWindowWidth, halfWindowHeight + 200)

var xVertice
var yVertice

var initialDirection = Vector2(0, 1)

var velocity = Vector2.ZERO
var direction = Vector2.ZERO
var speed = 20

var free_ball_vertical_angle: float = -0.3


func _ready():
	create_ball()
	direction = initialDirection
	self.set_physics_process(false)


func _physics_process(delta):
	
	velocity = Vector2.ZERO
	velocity = direction * speed
	
	var collision_info = move_and_collide(velocity * delta * speed)
	
	if direction == Vector2(1, 0) or direction == Vector2(-1, 0):
		direction.y = free_ball_vertical_angle
		
	if collision_info:
		var body = collision_info.collider
	
		if body.name == "PlayerPaddle":
			$Hit.play()
			direction = ball_bounce_direction(body)
			direction = self.direction.bounce(collision_info.normal)
			print(direction)
		
		elif body.is_in_group("bricks"):
			direction = self.direction.bounce(collision_info.normal)
			body.queue_free()
			$Hit.play()
			emit_signal("scored")
		
		elif body.is_in_group("avoid"):
			emit_signal("outOfBounds")
			
		else:
			direction = self.direction.bounce(collision_info.normal)



func ball_bounce_direction(body):
	
	direction = self.position - body.global_position
	direction = direction.normalized()
	return direction


func _unhandled_input(event):
	if event is InputEventKey:
		if event.pressed and event.scancode == KEY_SPACE:
			self.set_physics_process(true)



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
