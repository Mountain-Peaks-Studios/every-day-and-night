extends TileMap

var width := 256
var height := 256
var iterator = 0


var spawnX = 10
var spawnY = 10
	
func _ready():
	make_back_black()
	map()

func make_back_black():
	for x in width:
		for y in height:
			set_cell(0,Vector2(x,y),0 , Vector2(0,0))
			

func rectangle(locX: int, locY: int, sizeX: int, sizeY: int):
	for x in sizeX:
		for y in sizeY:
			set_cell(0,Vector2(locX+x,locY+y),0,Vector2(8,5))

func positiveCorridor(locX1: int, locY1: int, locX2: int, locY2: int):
	
	var width = 4
	# Horizontal
	if locX2 - locX1 > locY2 - locY1:
		for x in locX2 - locX1:
			for w in width:
				set_cell(0,Vector2(locX1 + x,locY1 - 4 - w),0,Vector2(11,15))
	# Vertical
	else:
		for y in locY2 - locY1:
			for w in width:
				set_cell(0,Vector2(locX1 - 4 - w,locY1 + y),0,Vector2(11,15))
	
func negativeCorridor(locX1: int, locY1: int, locX2: int, locY2: int):
	
	var width = 4
	# Horizontal
	if locX2 - locX1 > locY2 - locY1:
		for x in locX2 - locX1:
			for w in width:
				set_cell(0,Vector2(locX1 + x + 20,locY1 - 4 - w),0,Vector2(11,15))
	# Vertical
	else:
		for y in locY2 - locY1:
			for w in width:
				set_cell(0,Vector2(locX1 - 4 - w,locY1 + y + 20),0,Vector2(11,15))

func map():
	#starting room
	rectangle(spawnX, spawnY, 10, 10)
	
	#going right on x axis c times
	drawRight(5)
	drawDown(5)
	drawLeft(5)
	drawUp(5)
	

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

func _input(event: InputEvent):
	if event.is_action_pressed("scene_reload"):
	#	get_tree().reload_current_scene()
		set_cell(1, Vector2(0,iterator),0, Vector2(8,5))
		iterator += 1
