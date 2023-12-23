extends StaticBody2D

var windowWidth = OS.get_window_size().x
var windowHeight = OS.get_window_size().y

var numberofbricks: int
var brickWidth = 50
var brickHeight = 40

var brickColor = Color(0.78, 0.28, 0.28, 1)

func _ready():
	randomize()
	create_bricks(1)
	
func create_bricks(level):
	var x = rand_range(windowWidth / 7, windowWidth / 3)
	var y = brickHeight
	var z = 0
	
	var rowChanged = 0
	
	numberofbricks = level*50*0.1
	numberofbricks = clamp(numberofbricks, 62, 62)
	
	var maxHorizontalSpace = windowWidth - x
	var maxVerticalSpace = (windowHeight / 2) - brickHeight
	
	var brickSpace = Vector2(maxHorizontalSpace, maxVerticalSpace)
	
	#var maxHorizontalBricks: int = brickSpace.x / numberofbricks
	
	while numberofbricks > 0:
		var brickShape = Polygon2D.new()
		var brickVertex = PoolVector2Array()
		
		brickVertex.push_back(Vector2(x, y))
		brickVertex.push_back(Vector2(x + brickWidth, y))
		brickVertex.push_back(Vector2(x + brickWidth, y + brickHeight))
		brickVertex.push_back(Vector2(x, y + brickHeight))
		
		brickShape.set_polygon(brickVertex)
		brickShape.set_color(brickColor)
		
		x += brickWidth + 10
		
		if x > maxHorizontalSpace - z:
			y += brickHeight + 10
			x = rand_range(windowWidth / 7, windowWidth / 4)
			rowChanged += 1
			change_color(rowChanged)
			maxHorizontalSpace = windowWidth - x
			
			if y > maxVerticalSpace:
				break
		
		numberofbricks -= 1
		brickShape.add_to_group("bricks")
		self.add_child(brickShape, true)
		var brickCollision = CollisionPolygon2D.new()
		brickCollision.set_polygon(brickVertex)
		self.add_child(brickCollision, true)

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


