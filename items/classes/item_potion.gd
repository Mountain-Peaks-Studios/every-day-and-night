class_name ItemPotion
extends Item

@export var boost: int
@export var duration: float

# Item functionality
func drink(target: CharacterBody2D, variable_to_boost, timer: Timer) -> void:
	VariablesToKeep.variable_to_boost += boost
	timer.start(duration)
	timer.timeout.connect(_on_timer_timeout)

# Perform on timer timeout
func _on_timer_timeout():
	VariablesToKeep.variable_to_boost -= boost
