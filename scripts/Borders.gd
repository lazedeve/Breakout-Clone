extends Node2D

var windowWidth = OS.get_window_size().x
var windowHeight = OS.get_window_size().y

var halfWindowWidth = windowWidth / 2
var halfWindowHeight = windowHeight / 2

func _ready():
	topBorder()
	rightBorder()
	leftBorder()

func topBorder():
	var topBorderPolygon = Polygon2D.new()
	var topBorderVertices = PoolVector2Array()
	
	topBorderVertices.push_back(Vector2(0, 0))
	topBorderVertices.push_back(Vector2(windowWidth, 0))
	topBorderVertices.push_back(Vector2(windowWidth, 10))
	topBorderVertices.push_back(Vector2(0, 10))
	
	topBorderPolygon.set_polygon(topBorderVertices)
	topBorderPolygon.set_color(Color.white)
	self.add_child(topBorderPolygon)
	
	var topBorderCollision = CollisionPolygon2D.new()
	topBorderCollision.set_polygon(topBorderVertices)
	topBorderPolygon.add_child(topBorderCollision)

func rightBorder():
	var rightBorderPolygon = Polygon2D.new()
	var rightBorderVertices = PoolVector2Array()
	
	rightBorderVertices.push_back(Vector2(windowWidth, 0))
	rightBorderVertices.push_back(Vector2(windowWidth, windowHeight))
	rightBorderVertices.push_back(Vector2(windowWidth - 10, windowHeight))
	rightBorderVertices.push_back(Vector2(windowWidth - 10, 0))
	
	rightBorderPolygon.set_polygon(rightBorderVertices)
	rightBorderPolygon.set_color(Color.white)
	self.add_child(rightBorderPolygon)
	
	var rightBorderCollision = CollisionPolygon2D.new()
	rightBorderCollision.set_polygon(rightBorderVertices)
	rightBorderPolygon.add_child(rightBorderCollision)

func leftBorder():
	var leftBorderPolygon = Polygon2D.new()
	var leftBorderVertices = PoolVector2Array()
	
	leftBorderVertices.push_back(Vector2(0, 0))
	leftBorderVertices.push_back(Vector2(0, windowHeight))
	leftBorderVertices.push_back(Vector2(10, windowHeight))
	leftBorderVertices.push_back(Vector2(10, 0))
	
	leftBorderPolygon.set_polygon(leftBorderVertices)
	leftBorderPolygon.set_color(Color.white)
	self.add_child(leftBorderPolygon)
	
	var leftBorderCollision = CollisionPolygon2D.new()
	leftBorderCollision.set_polygon(leftBorderVertices)
	leftBorderPolygon.add_child(leftBorderCollision)
