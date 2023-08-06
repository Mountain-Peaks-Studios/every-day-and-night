extends StateMachine

# Called before the node enters the scene tree.
func _init() -> void:
	_add_state("idle")
	_add_state("move")
	_add_state("hurt")
	_add_state("dead")


# Called when the node enters the scene tree.
func _ready() -> void:
	set_state(states.idle)


# Performed as long as the state is set
func _state_logic(_delta: float) -> void:
	if state == states.idle or state == states.move:
		parent.handle_input()
		parent.handle_movement()


# Change the state
func _get_transition() -> int:
	match state:
		states.idle: # idle -> move
			if parent.velocity.length() > 10:
				return states.move
		states.move: # move -> idle
			if parent.velocity.length() < 10:
				return states.idle
		states.hurt: # hurt -> idle
			if not animation_player.is_playing():
				return states.idle
	return -1


# Performed on a new state enter
func _enter_state(_previous_state: int, new_state: int) -> void:
	match new_state:
		states.idle: # Play 'idle' animation
			animation_player.play("PlayerAnim/idle")
		states.move: # Play 'move' animation
			animation_player.play("PlayerAnim/move")
		states.hurt: # Play 'hurt' animation
			animation_player.play("PlayerAnim/hurt")
		states.dead: # Play 'dead' animation
			animation_player.play("PlayerAnim/dead")
