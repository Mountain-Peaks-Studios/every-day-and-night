extends Enemy

@onready var hitbox: Area2D = $Hitbox

# Update every frame
func _process(_delta: float) -> void:
	hitbox.knockback_direction = velocity.normalized()
