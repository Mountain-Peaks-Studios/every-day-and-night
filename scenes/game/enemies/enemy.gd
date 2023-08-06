class_name Enemy
extends GameCharacter

@onready var player: GameCharacter = get_tree().current_scene.get_node("Player")
@onready var nav_agent: NavigationAgent2D = $EnemyNavigationAgent2D
@onready var path_timer: Timer = $PathTimer

# Handle the pathfinding
func handle_chase() -> void:
	if not nav_agent.is_target_reached():
		var vector_to_next_point: Vector2 = nav_agent.get_next_path_position() - global_position
		var distance_to_next_point: float = vector_to_next_point.length()
		movement_direction = vector_to_next_point
	
	flip() # Flip the sprite according to the direction


# Flip the sprite according to the direction
func flip() -> void:
	if to_local(nav_agent.get_next_path_position()).normalized().x > 0:
		animated_sprite.flip_h = false
	else:
		animated_sprite.flip_h = true


# Update the path to the player on timer timeout
func _on_path_timer_timeout() -> void:
	if is_instance_valid(player):
		nav_agent.target_position = player.position
	else:
		path_timer.stop()
		movement_direction = Vector2.ZERO
