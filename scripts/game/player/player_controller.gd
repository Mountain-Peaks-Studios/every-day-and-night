extends GameCharacter

@onready var sword: Node2D = get_node("Sword")
@onready var sword_animation_player: AnimationPlayer = sword.get_node("SwordAnimationPlayer")

# Update every frame
func _process(_delta: float) -> void:
	follow_cursor() # Make the player follow the cursor direction
	if Input.is_action_just_pressed("attack") and not sword_animation_player.is_playing():
		handle_melee() # Perform melee attack

# Makes the player follow the direction of the mouse cursor
func follow_cursor() -> void:
	# Flip character's sprite
	var mouse_direction: Vector2 = (get_global_mouse_position() - global_position).normalized()
	if mouse_direction.x > 0:
		animated_sprite.flip_h = false
	else:
		animated_sprite.flip_h = true
	
	# Rotate the sword
	sword.rotation = mouse_direction.angle()
	if sword.scale.y == 1 and mouse_direction.x < 0:
		sword.scale.y = -1
	elif sword.scale.y == -1 and mouse_direction.x > 0:
		sword.scale.y = 1

# Handles player input to set the character's velocity.
func handle_input() -> void:
	# Reset the velocity to zero.
	movement_direction = Vector2.ZERO
	
	# Check for input actions and modify the direction of movement accordingly.
	if Input.is_action_pressed("ui_right"):
		movement_direction += Vector2.RIGHT
	if Input.is_action_pressed("ui_left"):
		movement_direction += Vector2.LEFT
	if Input.is_action_pressed("ui_down"):
		movement_direction += Vector2.DOWN
	if Input.is_action_pressed("ui_up"):
		movement_direction += Vector2.UP

# Handles player's melee attacks
func handle_melee() -> void:
	sword_animation_player.play("PlayerAnim/sword_attack")
