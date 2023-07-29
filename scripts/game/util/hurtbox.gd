extends Area2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

#func _on_hurtbox_area_entered(hitbox):
#	receive_damage(hitbox.damage)
#	print(hitbox.get_parent().name + "'s hitbox touched " + name + "'s hurtbox and dealt " + str(base_damage))
#
#
## Method for additional damage calculations
#func receive_damage(base_damage: int):
#	var actual_damage = base_damage
#
#	current_health -= actual_damage
