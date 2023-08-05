class_name GameCharacter
extends CharacterBody2D

const FRICTION: float = 0.15

@export var acceleration: int = 10
@export var max_speed: int = 40 # REQUIRED IN VARIABLES TO KEEP SINGLETON

var movement_direction: Vector2 = Vector2.ZERO

@onready var animated_sprite: AnimatedSprite2D = get_node("AnimatedSprite2D")


# Update every frame
func _physics_process(_delta: float) -> void:
	print(position)
	move_and_slide()
	velocity = lerp(velocity, Vector2.ZERO, FRICTION)


# Handle character movement
func handle_movement() -> void:
	movement_direction = movement_direction.normalized()
	velocity += movement_direction * acceleration
	velocity = velocity.limit_length(max_speed)
