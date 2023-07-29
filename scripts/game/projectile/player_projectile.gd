extends Hitbox

@export var SPEED: int = 400


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var direction = Vector2.RIGHT.rotated(rotation)
	global_position += SPEED * direction * delta


func _on_area_entered() -> void:
	destroy()


func _on_body_entered() -> void:
	destroy()


func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	destroy()


func destroy() -> void:
	queue_free()

