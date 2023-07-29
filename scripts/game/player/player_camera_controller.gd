extends Camera2D

# Private variables
var current_zoom = zoom


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float):
	handle_zoom_input()


func handle_zoom_input() -> void:
	if Input.is_action_just_pressed("zoom_in"):
		zoom = current_zoom * Vector2(2, 2)
	if Input.is_action_just_pressed("zoom_out"):
		zoom = current_zoom * Vector2(0.5, 0.5)
	
	current_zoom = zoom
