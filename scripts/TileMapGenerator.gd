extends TileMap

var width := 256
var height := 256
var iterator = 0

func _ready():
	make_back_black()
	
	rectangle(10,10,10,10)
	
	
	#for i in 100:
	#	make_a_random_box() 

func make_back_black():
	for x in width:
		for y in height:
			set_cell(0,Vector2(x,y),0 , Vector2(0,0))		
			

func rectangle(locX: int, locY: int, offsetX: int, offsetY: int):
	for x in locX:
		for y in locY:
			set_cell(0,Vector2(x+offsetX,y+offsetY),0,Vector2(8,5))

func corridor():
	pass

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
	
