extends CharacterBody2D

func _ready():
	pass


func _physics_process(delta):
	pass


func _on_hurtbox_area_entered(area):
	queue_free()
