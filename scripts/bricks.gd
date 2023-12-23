extends StaticBody2D

var numberofbricks: int
var brickWidth = 50
var brickHeight = 40

var brickShape

func _ready():
	randomize()
	create_bricks()

func create_bricks():
	
	brickShape = Polygon2D.new()
	var brickVertex = PoolVector2Array()
		
	brickVertex.push_back(Vector2(0, 0))
	brickVertex.push_back(Vector2(brickWidth, 0))
	brickVertex.push_back(Vector2(brickWidth, brickHeight))
	brickVertex.push_back(Vector2(0, brickHeight))
		
	brickShape.set_polygon(brickVertex)
	self.add_child(brickShape, true)
	var brickCollision = CollisionPolygon2D.new()
	brickCollision.set_polygon(brickVertex)
	self.add_child(brickCollision, true)
	self.add_to_group("bricks")

func set_brick_position(brickPosition):
	self.position = brickPosition

func set_brick_color(brickColor):
	brickShape.set_color(brickColor)
