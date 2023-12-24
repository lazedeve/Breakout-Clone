class_name Borders
extends StaticBody2D

var windowWidth = OS.get_window_size().x
var windowHeight = OS.get_window_size().y

var halfWindowWidth = windowWidth / 2
var halfWindowHeight = windowHeight / 2

export var rightBorderWidth = 10
export var leftBorderWidth = 10
export var topBorderWidth = 10
export var bottomBorderWidth = 20

func _ready():
	topBorder()
	rightBorder()
	leftBorder()
	bottomBorder()
	add_to_group("borders")

func topBorder():
	var topBorderPolygon = Polygon2D.new()
	var topBorderVertices = PoolVector2Array()
	
	topBorderVertices.push_back(Vector2(leftBorderWidth, 0))
	topBorderVertices.push_back(Vector2(windowWidth - rightBorderWidth, 0))
	topBorderVertices.push_back(Vector2(windowWidth - rightBorderWidth, topBorderWidth))
	topBorderVertices.push_back(Vector2(0, topBorderWidth))
	
	topBorderPolygon.set_polygon(topBorderVertices)
	topBorderPolygon.set_color(Color.white)
	self.add_child(topBorderPolygon, true)
	
	var topBorderCollision = CollisionPolygon2D.new()
	topBorderCollision.set_polygon(topBorderVertices)
	self.add_child(topBorderCollision, true)


func bottomBorder():
	var bottomBorderBody = StaticBody2D.new()
	var bottomBorderPolygon = Polygon2D.new()
	var bottomBorderVertices = PoolVector2Array()
	
	bottomBorderVertices.push_back(Vector2(leftBorderWidth, windowHeight))
	bottomBorderVertices.push_back(Vector2(windowWidth - rightBorderWidth, windowHeight))
	bottomBorderVertices.push_back(Vector2(windowWidth - rightBorderWidth, windowHeight - bottomBorderWidth))
	bottomBorderVertices.push_back(Vector2(leftBorderWidth, windowHeight - bottomBorderWidth))
	
	bottomBorderPolygon.set_polygon(bottomBorderVertices)
	bottomBorderPolygon.set_color(Color.red)
	bottomBorderBody.add_child(bottomBorderPolygon, true)
	
	var bottomBorderCollision = CollisionPolygon2D.new()
	bottomBorderCollision.set_polygon(bottomBorderVertices)
	bottomBorderBody.add_child(bottomBorderCollision, true)
	
	self.add_child(bottomBorderBody)
	bottomBorderBody.add_to_group("avoid")

func rightBorder():
	var rightBorderPolygon = Polygon2D.new()
	var rightBorderVertices = PoolVector2Array()
	
	rightBorderVertices.push_back(Vector2(windowWidth, 0))
	rightBorderVertices.push_back(Vector2(windowWidth, windowHeight))
	rightBorderVertices.push_back(Vector2(windowWidth - rightBorderWidth, windowHeight))
	rightBorderVertices.push_back(Vector2(windowWidth - rightBorderWidth, 0))
	
	rightBorderPolygon.set_polygon(rightBorderVertices)
	rightBorderPolygon.set_color(Color.white)
	self.add_child(rightBorderPolygon, true)
	
	var rightBorderCollision = CollisionPolygon2D.new()
	rightBorderCollision.set_polygon(rightBorderVertices)
	self.add_child(rightBorderCollision, true)

func leftBorder():
	var leftBorderPolygon = Polygon2D.new()
	var leftBorderVertices = PoolVector2Array()
	
	leftBorderVertices.push_back(Vector2(0, 0))
	leftBorderVertices.push_back(Vector2(0, windowHeight))
	leftBorderVertices.push_back(Vector2(leftBorderWidth, windowHeight))
	leftBorderVertices.push_back(Vector2(leftBorderWidth, 0))
	
	leftBorderPolygon.set_polygon(leftBorderVertices)
	leftBorderPolygon.set_color(Color.white)
	self.add_child(leftBorderPolygon, true)
	
	var leftBorderCollision = CollisionPolygon2D.new()
	leftBorderCollision.set_polygon(leftBorderVertices)
	self.add_child(leftBorderCollision, true)
