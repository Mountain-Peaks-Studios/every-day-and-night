extends TileMap

var width := 512
var height := 300

func _ready():
	make_back_black()
	for i in 100:
		make_a_box()


func make_back_black():
	for x in width:
		for y in height:
			set_cell(1,Vector2(x,y),0 , Vector2(1,1))		
			



func make_a_box():
	var margin := 40
	var xOffest := randf_range(margin, width-margin)
	var yOffest := randf_range(margin, height-margin)
	
	var xRoom := randf_range(10,30)
	var yRoom := randf_range(10,30)
	for x in xRoom:
		for y in yRoom:
			set_cell(1,Vector2(x+xOffest,y+yOffest))


func _input(event: InputEvent):
	if event.is_action_pressed("scene_reload"):
		get_tree().reload_current_scene()
