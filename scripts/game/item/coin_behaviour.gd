extends Node2D

var amount = 1

func _on_collider_area_entered(area) -> void:
	if area.name == "PlayerHurtbox":
		area.get_parent().add_coins(amount)
		queue_free()
