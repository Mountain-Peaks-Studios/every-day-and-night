extends StateMachine

# Called before the node enters the scene tree.
func _init() -> void:
	_add_state("chase")
	_add_state("hurt")
	_add_state("dead")


# Called when the node enters the scene tree.
func _ready() -> void:
	set_state(states.chase)


# Performed as long as the state is set
func _state_logic(_delta: float) -> void:
	if state == states.chase:
		parent.handle_movement()
		parent.handle_chase()


# Change the state
func _get_transition() -> int:
	match state:
		states.hurt: # hurt -> chase
			if not animation_player.is_playing():
				return states.chase
	return -1


# Performed on a new state enter
func _enter_state(_previous_state: int, _new_state: int) -> void:
	match _new_state:
		states.chase:
			animation_player.play("EnemyAnim/fly")
		states.hurt:
			animation_player.play("EnemyAnim/hurt")
		states.dead:
			animation_player.play("EnemyAnim/dead")
