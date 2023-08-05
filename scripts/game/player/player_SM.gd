extends StateMachine

# Called before the node enters the scene tree.
func _init() -> void:
	_add_state("idle")
	_add_state("move")


# Called when the node enters the scene tree.
func _ready() -> void:
	set_state(states.idle)


# Performed as long as the state is set
func _state_logic(_delta: float) -> void:
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
	return -1


# Performed on a new state enter
func _enter_state(_previous_state: int, new_state: int) -> void:
	match new_state:
		states.idle: # Play 'idle' animation
			animation_player.play("PlayerAnim/idle")
		states.move: # Play 'move' animation
			animation_player.play("PlayerAnim/move")
