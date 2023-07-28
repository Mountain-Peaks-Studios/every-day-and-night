extends Camera2D

# Private variables
var currentZoom = zoom

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	handle_zoom_input()

func handle_zoom_input():
	
	if Input.is_action_just_pressed("zoom_in"):
		zoom = currentZoom * Vector2(2, 2)
	if Input.is_action_just_pressed("zoom_out"):
		zoom = currentZoom * Vector2(0.5, 0.5)
	
	currentZoom = zoom
