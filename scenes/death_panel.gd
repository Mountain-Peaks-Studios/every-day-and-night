extends Panel

# Perform when NextRunButton is pressed
func _on_next_run_button_pressed():
	get_tree().reload_current_scene()
	get_tree().paused = false
