class_name Enemy
extends GameCharacter

@onready var player: GameCharacter = get_tree().current_scene.get_node("Player")
@onready var nav_agent: NavigationAgent2D = $EnemyNavigationAgent2D 

# Update every frame
func _process(delta: float) -> void:
	# Handle the pathfinding
	movement_direction = to_local(nav_agent.get_next_path_position()).normalized()

	flip() # Flip the sprite according to the direction


# Update the path to the player on timer timeout
func _on_timer_timeout() -> void:
	nav_agent.target_position = player.global_position


# Flip the sprite according to the direction
func flip() -> void:
	if to_local(nav_agent.get_next_path_position()).normalized().x > 0:
		animated_sprite.flip_h = false
	else:
		animated_sprite.flip_h = true
