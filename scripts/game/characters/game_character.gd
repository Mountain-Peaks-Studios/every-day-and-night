class_name GameCharacter
extends CharacterBody2D

const FRICTION: float = 0.15

@export var health: int = 2
@export var acceleration: int = 10
@export var max_speed: int = 40 # REQUIRED IN VARIABLES TO KEEP SINGLETON

var movement_direction: Vector2 = Vector2.ZERO

@onready var state_machine: Node = get_node("StateMachine")
@onready var animated_sprite: AnimatedSprite2D = get_node("AnimatedSprite2D")


# Update every frame
func _physics_process(_delta: float) -> void:
	move_and_slide()
	velocity = lerp(velocity, Vector2.ZERO, FRICTION)


# Handles character movement
func handle_movement() -> void:
	movement_direction = movement_direction.normalized()
	velocity += movement_direction * acceleration
	velocity = velocity.limit_length(max_speed)


# Handles receiving damage
func handle_damage(dam: int, dir: Vector2, force: int) -> void:
	health -= dam
	state_machine.set_state(state_machine.states.hurt)
	velocity += dir * force
