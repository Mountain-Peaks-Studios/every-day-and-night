extends TileMap

var width := 512
var height := 512
var iterator = 0


var spawnX = 10
var spawnY = 10
	
func _ready():
	#make_back_black()
	map()

func make_back_black():
	for x in width:
		for y in height:
			set_cell(0,Vector2(x,y),0 , Vector2(0,0))
			

func rectangle(locX: int, locY: int, sizeX: int, sizeY: int):
	for x in sizeX:
		for y in sizeY:
			if x == 0 or x == 9 or y == 0 or y == 9:
				set_cell(1,Vector2(locX+x,locY+y),0,Vector2(15,6))
			else:
				set_cell(0,Vector2(locX+x,locY+y),0,Vector2(2,2))

func specialRectangle(locX: int, locY: int, sizeX: int, sizeY: int,atlasReference :Vector2i):
	for x in sizeX:
		for y in sizeY:
			set_cell(0,Vector2(locX+x,locY+y),0,atlasReference)

func positiveCorridor(locX1: int, locY1: int, locX2: int, locY2: int):
	
	var width = 4
	# Horizontal
	if locX2 - locX1 > locY2 - locY1:
		for x in locX2 - locX1 + 2:
			for w in width:
				if x == locX2 - locX1 + 1 or x == 0:  #door condition
					set_cell(2,Vector2(locX1 + x - 1,locY1 - 4 - w),1,Vector2(3,5))
				else:
					set_cell(2,Vector2(locX1 + x - 1,locY1 - 4 - w),0,Vector2(11,15))
	# Vertical
	else:
		for y in locY2 - locY1 + 2:
			for w in width:
				if y == locY2 - locY1 + 1 or y == 0:
					set_cell(2,Vector2(locX1 - 4 - w,locY1 + y - 1),1,Vector2(3,5))
				else:
					set_cell(2,Vector2(locX1 - 4 - w,locY1 + y - 1),0,Vector2(11,15))
				
	
func negativeCorridor(locX1: int, locY1: int, locX2: int, locY2: int):
	
	var width = 4
	# Horizontal
	if locX2 - locX1 > locY2 - locY1:
		for x in locX2 - locX1 + 2:
			for w in width:
				set_cell(2,Vector2(locX1 + x + 20 - 1,locY1 - 4 - w),0,Vector2(11,15))
	# Vertical
	else:
		for y in locY2 - locY1 + 2:
			for w in width:
				set_cell(2,Vector2(locX1 - 4 - w,locY1 + y + 20 -1),0,Vector2(11,15))

func map():
	#set spawn room
	spawnX = 10
	spawnY = 10
	
	
	#starting room
	rectangle(spawnX, spawnY, 10, 10)
	
	#going right on x axis c times
	
	###BASIC LEVEL GENERATION EXAMPLE
	
	
	##Below are randomized structures
	
	#Trident
	if randi_range(1,2) == 1:
		drawRight(randi_range(1,2))
		drawUp(1)
		drawRight(1)
		drawRight(1)
		drawDown(1)
		moveLeft(1)
		moveLeft(1)
		drawDown(1)
		drawRight(1)
		drawRight(1)
		drawUp(1)


	#Wibbly Wobbly
	if randi_range(1,2) == 1:
		drawRight(1)
		drawDown(1)
		drawRight(1)
		drawUp(1)
		drawRight(1)
	
	
	#Conglomeration
	var conglomerationWidth = randi_range(2,3)
	var conglomerationHeight = randi_range(2,4)
	
	for x in conglomerationHeight:
		drawDown(1)
		
		for y in conglomerationWidth:
			drawRight(y)
			
			if randi_range(1,3) == 1:
				drawDown(1)
				drawUp(1)
			
			moveLeft(y)
	
	#basic end segment
	
	drawLeft(randi_range(1,2))
	
	drawHere(Vector2i(12,23))
	
	
func moveRight(rooms: int):
	spawnX += 20 * rooms
func moveLeft(rooms: int):
	spawnX -= 20 * rooms
func moveUp(rooms: int):
	spawnY += 20 * rooms
func moveDown(rooms: int):
	spawnY -= 20 * rooms

func drawRight(numberOfRooms: int):
	for c in numberOfRooms:
		spawnX += 20
		positiveCorridor(spawnX - 10, spawnY + 10, spawnX, spawnY + 10)
		
		rectangle(spawnX, spawnY, 10, 10)

func drawDown(numberOfRooms: int):
	for c in numberOfRooms:
		spawnY += 20
		positiveCorridor(spawnX + 10, spawnY - 10, spawnX + 10, spawnY)
		
		rectangle(spawnX, spawnY, 10, 10)

func drawLeft(numberOfRooms: int):
	for c in numberOfRooms:
		spawnX -= 20
		negativeCorridor(spawnX - 10, spawnY + 10, spawnX, spawnY + 10)
		
		rectangle(spawnX, spawnY, 10, 10)

func drawUp(numberOfRooms: int):
	for c in numberOfRooms:
		spawnY -= 20
		negativeCorridor(spawnX + 10, spawnY - 10, spawnX + 10, spawnY)
		
		rectangle(spawnX, spawnY, 10, 10)

func drawHere(atlasReference: Vector2i):
	specialRectangle(spawnX,spawnY,10,10, atlasReference)

func _input(event: InputEvent):
	if event.is_action_pressed("scene_reload"):
		get_tree().reload_current_scene()
