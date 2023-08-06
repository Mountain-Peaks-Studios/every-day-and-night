class_name Hitbox
extends Area2D

@export var damage: int = 1
@export var knockback_force: int = 300

var knockback_direction: Vector2 = Vector2.ZERO

@onready var collision_shape: CollisionShape2D = get_child(0)

# Called before the node enters the scene tree.
func _init() -> void:
	connect("body_entered", _on_body_entered)


# Called when the node enters the scene tree.
func _ready() -> void:
	assert(collision_shape != null)


# Peformed when a body enter the area
func _on_body_entered(body: PhysicsBody2D) -> void:
	body.handle_damage(damage, knockback_direction, knockback_force)
