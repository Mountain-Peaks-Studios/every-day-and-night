class_name StateMachine
extends Node

var states: Dictionary = {}
var previous_state: int = -1
var state: int = -1: set = set_state

@onready var parent: GameCharacter = get_parent()
@onready var animation_player: AnimationPlayer = parent.get_node("AnimationPlayer")


# Update every frame
func _physics_process(delta: float) -> void:
	# Check if state is null
	if state != -1:
		_state_logic(delta)
		var transition: int = _get_transition()
		if transition != -1:
			set_state(transition)


# Add a new state to the dictionary
func _add_state(new_state: String) -> void:
	states[new_state] = states.size()


# Set the state to the given one (getter of 'state' variable)
func set_state(new_state: int) -> void: 
	_exit_state(state)
	previous_state = state
	state = new_state
	_enter_state(previous_state, state)


# Performed as long as the state is set
func _state_logic(_delta: float) -> void:
	pass


# Change the state
func _get_transition() -> int:
	return -1


# Performed on a new state enter
func _enter_state(_previous_state: int, _new_state: int) -> void:
	pass


# Performed on the state exit
func _exit_state(_state_exited: int) -> void:
	pass
