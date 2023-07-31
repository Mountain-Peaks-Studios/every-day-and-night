extends Node2D

var amount = 1

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_collider_area_entered(area):
		if area.get_name() == "Player":
			if area.add_coins(amount):
				queue_free()
