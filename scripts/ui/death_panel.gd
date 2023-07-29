extends Panel

# Perform when NextRunButton is pressed
func _on_next_run_button_pressed() -> void:
	get_tree().reload_current_scene()
	VariablesToKeep.run_number += 1
	get_tree().paused = false
