extends TileMap

var width := 256
var height := 256
var iterator = 0

func _ready():
	make_back_black()
	
	
	map()
	
	
	

func make_back_black():
	for x in width:
		for y in height:
			set_cell(0,Vector2(x,y),0 , Vector2(0,0))
			

func rectangle(locX: int, locY: int, offsetX: int, offsetY: int):
	for x in locX:
		for y in locY:
			set_cell(0,Vector2(x+offsetX,y+offsetY),0,Vector2(8,5))

func corridor(locX1: int, locY1: int, locX2: int, locY2: int):
	
	var counter = 4
	if locX2 - locX1 > locY2 - locY1:
		for x in locX2 - locX1:
			for c in counter:
				set_cell(0,Vector2(locX1 + x,locY1 - 4 - c),0,Vector2(11,15))
	else:
		for y in locY2 - locY1:
			for c in counter:
				set_cell(0,Vector2(locX1 - 4 - c,locY1 + y),0,Vector2(11,15))
	
	
func map():
	
	var spawnX = 10
	var spawnY = 10
	
	var counterX = 5
	
	#starting room
	rectangle(10,10,spawnX,spawnY)
	
	#going right on x axis c times
	for c in counterX:
		corridor(spawnX*c + 10,spawnY + 10,30*c,10)
		
		rectangle(10,10,spawnX+20*(c+1),spawnY)
	
	spawnX = spawnX * ((counterX * 2) + 1)   
	
	var counterY = 5
	
	#going down on y axis c times
	
	for c2 in counterY:
		corridor(spawnX + 10, spawnY*c2 + 10, 10, 30*c2 )
		
		rectangle(10,10,spawnX,spawnY+20*(c2+1))
	spawnY = spawnY * ((counterY * 2) + 1) 
	
func make_a_random_box():
	var margin := 10
	var xOffest := randi_range(margin, width-margin)
	var yOffest := randi_range(margin, height-margin)
	
	var xRoom := randi_range(10,30)
	var yRoom := randi_range(10,30)
	for x in xRoom:
		for y in yRoom:
			set_cell(0,Vector2(x+xOffest,y+yOffest), 0, Vector2(8,5))


func _input(event: InputEvent):
	if event.is_action_pressed("scene_reload"):
	#	get_tree().reload_current_scene()
		set_cell(1, Vector2(0,iterator),0, Vector2(8,5))
		iterator += 1
	
