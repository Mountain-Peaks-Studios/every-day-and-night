class_name GameCharacter
extends CharacterBody2D

const FRICTION: float = 0.15

@export var acceleration: int = 40
@export var max_speed: int = 100 # REQUIRED IN VARIABLES TO KEEP SINGLETON

var movement_direction: Vector2 = Vector2.ZERO


# Update every frame
func _physics_process(_delta: float) -> void:
	move_and_slide()
	velocity = lerp(velocity, Vector2.ZERO, FRICTION)


# Handle character movement
func handle_movement() -> void:
	movement_direction = movement_direction.normalized()
	velocity += movement_direction * acceleration
	velocity = velocity.limit_length(max_speed)
